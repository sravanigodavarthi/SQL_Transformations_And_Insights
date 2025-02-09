Get the total quantity of each product sold per month

SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY  product_id, EXTRACT(MONTH FROM order_date)