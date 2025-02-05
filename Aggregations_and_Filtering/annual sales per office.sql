The first business query that you will create should answer the question 
about the annual sales per office in terms of quantity of items sold and the total sales income received.


SELECT  fct.office_key,
        dof.city,
        dof.state,
        dof.country,
        dof.territory,
        SUM(fct.quantity_ordered) AS total_quantity,
        SUM(fct.product_price*fct.quantity_ordered) AS total_price,
        EXTRACT(YEAR FROM fct.order_date) AS year
FROM fact_orders AS fct
JOIN dim_offices AS dof ON fct.office_key = dof.office_key
GROUP BY fct.office_key,
            EXTRACT(YEAR FROM fct.order_date),
            dof.city,
            dof.state,
            dof.country,
            dof.territory
ORDER BY fct.office_key ASC, year ASC