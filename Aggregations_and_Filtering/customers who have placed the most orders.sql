List the customers who have placed the most orders


SELECT COUNT(order_id) as max_num_of_orders, customer_id
FROM orders 
GROUP BY customer_id
ORDER BY max_num_of_orders DESC
LIMIT 1

