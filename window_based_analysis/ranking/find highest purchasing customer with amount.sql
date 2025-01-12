5. Write a Query to find highest purchasing customer with amount from each store on below columns.

cust_id, amount, store_id

considering: store_id, customer_id as primary key meaning no duplicate entries of customer in the same store

WITH cust_ranking_by_store AS(
SELECT cust_id, amount,
    DENSE_RANK() OVER(PARTITION BY store_id ORDER BY amount DESC) as cust_rnk
FROM store
)
SELECT cust_id, amount
FROM cust_ranking_by_store
WHERE cust_rnk = 1

considering: if duplicates of customer ids within the store

WITH total_amount AS(
SELECT cust_id, store_id, SUM(amount) as total_amount
FROM store
GROUP BY cust_id, store_id
), cust_ranking_by_store AS(
SELECT cust_id, total_amount,
    DENSE_RANK() OVER(PARTITION BY store_id ORDER BY total_amount DESC) as cust_rnk
FROM total_amount
)
SELECT cust_id, amount
FROM cust_ranking_by_store
WHERE cust_rnk = 1
