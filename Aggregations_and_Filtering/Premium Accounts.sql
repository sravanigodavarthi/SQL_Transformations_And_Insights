You are given a dataset that provides the number of active users per day per premium account. 
A premium account will have an entry for every day that it’s premium. However, a premium account may be temporarily discounted and considered not paid, this is indicated by a value of 0 in the final_price column for a certain day. 
Find out how many premium accounts that are paid on any given day are still premium and paid 7 days later.
Output the date, the number of premium and paid accounts on that day, and the number of how many of these accounts are still premium and paid 7 days later. Since you are only given data for a 14 days period, only include the first 7 available dates in your output.

account_id:text
entry_date:date
final_price:bigint
plan_size:bigint
users_visited_7d:bigint

SELECT 
    p1.entry_date AS date, 
    COUNT(p1.account_id) AS paid_accounts, 
    COUNT(p2.account_id) AS still_paid_after_7_days
FROM premium_accounts_by_day p1
LEFT JOIN premium_accounts_by_day p2 
    ON p1.account_id = p2.account_id 
    AND p1.entry_date + INTERVAL '7 days' = p2.entry_date
    AND p2.final_price <> 0
WHERE p1.final_price <> 0
AND p1.entry_date <= (SELECT MIN(entry_date) + INTERVAL '6 days' FROM premium_accounts_by_day)
GROUP BY p1.entry_date
ORDER BY p1.entry_date

