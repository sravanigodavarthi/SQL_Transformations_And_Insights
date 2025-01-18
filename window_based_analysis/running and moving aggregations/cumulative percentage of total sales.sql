Compute the cumulative percentage of total sales (amount) for each region, ordered by order_date.
Display the cumulative alongside other details.
Region  Order_Date Order_ID Amount
North 2014-01-15 1 500
North 2024-03-05 5 600
South 2024-01-20 2 700
East 2024-02-18 4 200

WITH Region_Sorted AS(
SELECT Region, Order_Date, Order_ID,
    SUM(Amount) OVER(
        PARTITION BY Region 
        ORDER BY Order_Date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Cumulative_amount,
    SUM(Amount) OVER(PARTITION BY Region) AS Total_amount
FROM sales
)
SELECT Region, Order_Date, Order_ID, ROUND((Cumulative_amount * 100.0 / Total_amount),2) AS Cumulative_Percentage
FROM Region_Sorted
ORDER BY Order_Date