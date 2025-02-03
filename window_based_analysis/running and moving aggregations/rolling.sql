Find the 3-month rolling average of total revenue from purchases given a table with users,
 their purchase amount, and date purchased (YYYY-MM-DD). Output the year-month (YYYY-MM) and 
 3-month rolling average of revenue, sorted from earliest month to latest month.


purchase
users amount purchase_date
1 100 2025/01/01
2 200 2025/01/08
1 100 2025/01/10
3 200 2025/01/08
2 100 2025/01/10
1 100 2025/02/01

with total_revenue_by_month AS(
    SELECT SUM(amount) as total_revenue, 
        DATE_TRUNC('month', purchase_date) as month_start_date
    FROM purchase
    GROUP BY DATE_TRUNC('month', purchase_date)
)
SELECT to_char(month_start_date, 'YYYY-MM') AS year_month,
    AVG(total_revenue) OVER(ORDER BY first_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as average_revenue
FROM total_revenue_by_month
ORDER BY month_start_date