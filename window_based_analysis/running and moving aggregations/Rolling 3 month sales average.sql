Create a Rolling 3-month sales average

Calculate the 3 month rolling average of sales for each region. If there aren't enough months
for a 3 month window, the rolling average should still be computed based on the available data.

Region Month Year Sales
North Jan 2024 15000
North Feb 2024 18000
North Mar 2024 20000
South Jan 2024 14000
South Feb 2024 16000

SELECT region, month, TO_DATE(CONCAT(month,' 1 ', year), 'Mon DD YYYY') as sales_date,
        Round(AVG(Sales) OVER(  
                                PARTITION BY region
                                ORDER BY year, TO_DATE(CONCAT(month,' 1 ', year), 'Mon DD YYYY')
                                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
                            ),2) as average_sale
FROM Sales

Output:
region	month	sales_date	average_sale
North	Jan	2024-01-01	15000.00
North	Feb	2024-02-01	16500.00
North	Mar	2024-03-01	17666.67
South	Jan	2024-01-01	14000.00
South	Feb	2024-02-01	15000.00