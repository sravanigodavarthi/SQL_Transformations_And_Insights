Find the first and last orders placed by each customer based on order_date.
Include their order ID's, amounts, and the difference in days between the first and last orders.

Order_ID Customer_ID Order_Date Amount
1 101 2014-01-15 500
2 102 2024-01-20 700
3 101 2024-02-10 300
4 103 2024-02-08 200
5 101 2024-03-05 600

WITH First_and_last_order AS(
SELECT Customer_ID, Order_ID, Amount, 
        ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY Order_Date ASC)AS first_order_rnk, 
        ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY Order_Date DESC)AS last_order_rnk
FROM orders o
)First_order AS(
        SELECT Customer_ID, Order_ID as first_order_id, Amount as first_order_amount, Order_Date as first_order_date
        FROM First_and_last_order
        WHERE first_order_rnk = 1
)last_order AS(
        SELECT Customer_ID, Order_ID as last_order_id, Amount as last_order_amount, Order_Date as last_order_date
        FROM First_and_last_order
        WHERE last_order_rnk = 1
)
SELECT f.Customer_ID, first_order_id, first_order_amount, first_order_date, last_order_id, last_order_amount, last_order_date,
        DATEDIFF(first_order_date, last_order_date) as days_diff
FROM First_order f 
INNER JOIN last_order l ON f.Customer_ID = l.customer_ID 