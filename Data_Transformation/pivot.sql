Write a query to pivot sales data to show monthly sales for each product.
Tables: sales (product_id, sale_amount, sale_date)
Recursive Queries

WITH monthly_sale_by_product AS(
SELECT product_id, EXTRACT(MONTH FROM sale_date) as month, SUM(sale_amount) as monthly_sale 
FROM sales
GROUP BY  product_id, EXTRACT(MONTH FROM sale_date)
)
SELECT product_id,
        CASE WHEN month = 1 THEN monthly_sale ELSE 0 END AS JAN,
        CASE WHEN month = 2 THEN monthly_sale ELSE 0 END AS FEB,
        CASE WHEN month = 3 THEN monthly_sale ELSE 0 END AS MARCH,
        CASE WHEN month = 4 THEN monthly_sale ELSE 0 END AS APRIL,
        CASE WHEN month = 5 THEN monthly_sale ELSE 0 END AS MAY,,
        CASE WHEN month = 6 THEN monthly_sale ELSE 0 END AS JUNE,
        CASE WHEN month = 7 THEN monthly_sale ELSE 0 END AS JULY,
        CASE WHEN month = 8 THEN monthly_sale ELSE 0 END AS AUG,
        CASE WHEN month = 9 THEN monthly_sale ELSE 0 END AS SEP,
        CASE WHEN month = 10 THEN monthly_sale ELSE 0 END AS OCT,
        CASE WHEN month = 11 THEN monthly_sale ELSE 0 END AS NOV,
        CASE WHEN month = 12 THEN monthly_sale ELSE 0 END AS DEC
FROM monthly_sale_by_product


1. Install the tablefunc Extension:
The crosstab function is part of the tablefunc extension in PostgreSQL. 
This extension provides various functions for transforming data, including crosstab.
To use crosstab, you need to ensure that the tablefunc extension is installed and enabled in your database.

You can enable it with the following command:
sql
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM crosstab(
    $$
    SELECT product_id, TO_CHAR(sale_date, 'YYYY-MM') as month, COALESCE(SUM(sale_amount),0) as monthly_sale 
    FROM sales
    GROUP BY  product_id, EXTRACT(MONTH FROM sale_date)
    ORDER BY product_id, month
    $$,
    $$
    SELECT DISTINCT TO_CHAR(sale_date, 'YYYY-MM') FROM sales ORDER BY 1
    $$
) AS pivot_table(product_id INT, "2024-01" NUMERIC, ...)