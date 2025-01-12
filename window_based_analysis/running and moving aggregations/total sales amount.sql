Running:
Rolling:
Column Name	Data Type	Description
store_id	INT	Unique identifier for the store
sale_date	DATE	Date of the sale
amount	DECIMAL	Sale amount

1 3/01/25 100
1 3/10/25 200
1 4/10/25 400
2 5/10/25 600

1 3/01/25 300
1 4/10/25 700
2 5/10/25 600


1. Write a query to compute the total sales amount:

For each store, calculate the cumulative total sales up to each sale date (running sum).
For each store, calculate the total sales in the last 7 days (rolling sum).

SELECT SUM(amount) OVER(PARTITION BY store_id ORDER BY sale_date) as total_sales,
        SUM(amount) OVER(PARTITION BY store_id ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as last_day_sale
FROM store 