Write SQL query to fetch Top 5 selling products for each day

Orders
order_id customer_id order_date total_amount 
1001 1 2024-07-01 10:00:00  2000.00
1002 2 2024-07-01 15:30:00  600.00
1003 2 2024-07-02 15:30:00  600.00


Orders_item
order_item order_id product_id quantity unit_price
1 1001 101 1 1200.00
2 1001 103 2 100.00
3 1002 103 1 100.00
4 1002 102 1 800.00

Products
Product_id Product_name Category Price
101 Laptop 1 1200.00
102 Phone 1 800.00
103 Headphones 1 100.00


Sample Output:

Product_id Product_name quantity Order_date
   103        Headphones              2      2024-07-01
   101         Laptop         1    2024-07-01

WITH RankedQuantity AS(
SELECT 
    p.Product_id,
    p.Product_name,
    SUM(oi.quantity) AS total_quantity,
    DATE(Order_date) AS order_date,
    DENSE_RANK() OVER(PARTITION BY DATE(Order_date) ORDER BY SUM(oi.quantity) DESC) AS quantity_rank
FROM Orders o 
JOIN Orders_item oi 
    ON o.order_id = oi.order_id 
JOIN Products p 
    ON oi.product_id = p.product_id
GROUP BY 
    DATE(Order_date),
    p.Product_id,
    p.Product_name
)
SELECT 
    Product_id,
    Product_name,
    total_quantity,
    Order_date
FROM RankedQuantity
WHERE quantity_rank <= 5
