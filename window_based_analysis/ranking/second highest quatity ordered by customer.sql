You are given a table Sales with the following columns:

order_id: The unique ID of the order.
customer_id: The ID of the customer who placed the order.
product_id: The ID of the product purchased.
quantity: The number of units purchased.
order_date: The date when the order was placed.

Your task is to write a query to find the second highest quantity ordered by each customer.

For example, for a given customer_id, if they have ordered products with quantities:

10, 15, 20, 20, 25
The second highest quantity is 20.

If a customer has only one distinct order quantity, return NULL.

WITH quantity_ranked AS(
SELECT customer_id, quantity
        DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY quantity DESC) AS quantity_rank
FROM Sales
)
SELECT customer_id,
        MAX(CASE WHEN quantity_rank = 2 THEN quantity ELSE NULL END) AS second_highest_quantity
FROM quantity_ranked
GROUP BY customer_id
