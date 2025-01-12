Given product and customer table write a query to fetch latest product name for each customer.
 
cust_id cust_name placed_id product_id
1        Adam      101       1          
1        Adam      102       2           
1        Adam      103       3
1        Adam      104       1
2        Ajay      101       1
2        Ajay      102       2
 
 
product_id product_name
1         mobile
2         laptop
3         music system
 
Output: Adam- mobile , Ajay -laptop


WITH products_ranked AS(
SELECT product_id, product_name, customer_id, customer_name,
    RANK() OVER(PARTITION BY customer_id ORDER BY placed_id DESC) product_rnk
FROM customer c
INNER JOIN product p ON c.product_id = p.product_id
)
SELECT customer_name, product_name
FROM products_ranked
WHERE product_rnk = 1


-- without windowfunctions

with latest_place_id AS(
SELECT cust_name, MAX(place_id)
FROM customer
GROUP BY cust_name
), latest_product_id AS(
SELECT pl.place_id, pl.cust_name, c.product_id
FROM latest_place_id pl
INNER JOIN  customer c ON pl.place_id = c.place_id
)
SELECT lp.cust_name, p.product_name
FROM latest_product_id lp
INNER JOIN product p ON lp.product_id = p.product_id