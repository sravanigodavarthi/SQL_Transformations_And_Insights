Rank customer by their total spending, but only consider orders with an amount less than or equal to $500

Order_ID Customer_ID Order_ID Order_Amount
1 C001 2024-01-10 300
2 C002 2024-01-12 450
3 C003 2024-04-15 600

WITH total_spending AS(
SELECT Customer_ID, SUM(Order_Amount) AS total_spending
FROM orders
WHERE Order_Amount <= 500
GROUP BY Customer_ID
)
SELECT Customer_ID,
    DENSE_RANK() OVER(ORDER BY total_spending DESC) as customer_rnk
FROM total_spending


Customer_ID	Total_Spending	Customer_Rnk
C001	500	1
C002	500	1
C003	450	2

WITH total_spending AS(
SELECT Customer_ID, SUM(Order_Amount) AS total_spending
FROM orders
WHERE Order_Amount <= 500
GROUP BY Customer_ID
)
SELECT Customer_ID,
    RANK() OVER(ORDER BY total_spending DESC) as customer_rnk
FROM total_spending

Customer_ID	Total_Spending	Customer_Rnk
C001	500	1
C002	500	1
C003	450	3

C001 and C002 have the same spending (500), so they both get rank 1.
C003 gets rank 3 (because RANK() skips 2 due to ties)