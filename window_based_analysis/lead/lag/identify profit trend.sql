identify whether the profit is increasing or decreasing

Transaction_id Transaction_date Profit Profit_trend
1 2023-01 10 No Change
2 2023-02 20 Increase
3 2023-03 5  Decrease
4 2023-04 15 Increase

SELECT Transaction_id, 
        CASE 
            WHEN Profit > LAG(Profit) OVER(ORDER BY Transaction_date) THEN 'increase'
            WHEN Profit < LAG(Profit) OVER(ORDER BY Transaction_date) THEN 'decrease'
            ELSE 'No Change'
        END AS Profit_trend
FROM Transaction