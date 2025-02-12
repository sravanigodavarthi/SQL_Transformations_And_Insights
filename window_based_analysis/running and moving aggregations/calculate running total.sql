Calculate running total

Transaction_id Transaction_date Profit running_total 
1 2023-01 10 10
2 2023-02 20 30
3 2023-03 5  35
4 2023-04 15 50


SELECT Transaction_id, Transaction_date,
        SUM(Profit) OVER(ORDER BY Transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM Transactions

