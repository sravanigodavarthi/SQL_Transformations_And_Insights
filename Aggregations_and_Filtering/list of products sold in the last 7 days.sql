Get the list of products sold in the last 7 days
sales table has product_id and sale_date columns.
sale_date is stored in a DATE or TIMESTAMP format.

SELECT DISTINCT product_id, sale_date   
FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '7' DAY


