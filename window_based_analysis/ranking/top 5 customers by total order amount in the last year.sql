2. Write a Query to find the top 5 customers by total order amount in the last year 

Hint: Join two tables on customer_id
join 2 tables on reference key
first have to get last year data
if have to consider ties, out top 5 ranks than dense rank if top 5 rows than row_number

WITH ranked_total_amount AS(
SELECT customer_id, customer_name, dense_rank() over(order by SUM(total_amount) DESC) as rnk
FROM order o
INNER JOIN customer c ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN DATE_TRUNC('year',CURRENT_DATE) - INTERVAL '1 year' AND
                                                DATE_TRUNC('year',CURRENT_DATE) - INTERVAL '1 day'
GROUP BY customer_id, customer_name
)
SELECT customer_id, customer_name
FROM ranked_total_amount
WHERE rnk <= 5