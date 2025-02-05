Now you've got a business question about the average sales (in terms of units and price) 
of each product line per month and year.


SELECT dP.product_line
        ,fct.product_key
        ,AVG(fct.quantity_ordered) AS avg_quantity
        ,AVG(fct.product_price*quantity_ordered) AS avg_price
        ,EXTRACT(YEAR FROM fct_ordered_date) AS year
        ,EXTRACT(MONTH FROM fct_ordered_date) AS month
FROM fact_orders AS fct
JOIN dim_products AS dP ON fct.product_key = dP.product_key
GROUP BY dP.product_line
        ,fct.product_key
        ,EXTRACT(YEAR FROM fct_ordered_date)
        ,EXTRACT(MONTH FROM fct_ordered_date)
ORDER BY dP.product_line ASC, year, month