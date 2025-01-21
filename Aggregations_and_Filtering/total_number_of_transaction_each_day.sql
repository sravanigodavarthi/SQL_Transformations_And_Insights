calculate the total number of transactions per user for each day

Transactions Table
Transaction_ID	User_ID	Transaction_Date	Amount
101	1	2025-01-15	50
102	1	2025-01-15	30
103	1	2025-01-16	20
104	2	2025-01-15	40
105	2	2025-01-15	60
106	2	2025-01-16	25
107	3	2025-01-16	100
108	3	2025-01-16	20
109	3	2025-01-17	70

SELECT User_ID, SUM(Amount) as total_transactions
FROM Transactions
GROUP BY User_ID, Transaction_Date 



