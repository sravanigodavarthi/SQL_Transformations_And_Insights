1. Write an SQL query to find the top 3 customers who spent the most in the last month, along with their total spending.
Tables: transactions (customer_id, amount, transaction_date)
In case of a tie (customers with the same total spending), 
select the customer with the lowest customer_id
Window Functions

WITH monthly_spending AS(
SELECT customer_id, SUM(amount) as total_spending
FROM transactions
WHERE transaction_date BETWEEN
                            DATE_TRUNC('month',CURRENT_DATE) - INTERVAL '1 month'
                        AND
                            DATE_TRUNC('month',CURRENT_DATE) - INTERVAL '1 day'
GROUP BY customer_id
), with_ranking AS(
SELECT customer_id, 
        total_spending, 
        DENSE_RANK() OVER(ORDER BY total_spending DESC, customer_id ASC) AS cst_rnk
FROM monthly_spending
)
SELECT total_spending, customer_id
FROM with_ranking
WHERE cst_rnk <=3