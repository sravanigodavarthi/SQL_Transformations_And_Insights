Find the number of orders placed each day

SELECT order_date, COUNT(order_id) AS total_orders
FROM orders
GROUP BY  order_date