Fetch the total sales for each dept, total sales of all depts,
highest selling employee in the dept and the employee details

sales
EMP_ID Dept Sales 
1 A 100
2 B 200
3 C 300
4 D 400
3 A 300

Employees
ID Name Age
1 E1 30
2 E2 40
3 E3 35
4 E4 45

WITH sales_rank_per_dpt AS (
    SELECT 
        SUM(Sales) OVER() AS total_sales_all_dept,  -- Total sales of all departments
        SUM(Sales) OVER(PARTITION BY Dept) AS total_sales_per_dept,  -- Total sales per department
        dense_rank() OVER(PARTITION BY Dept ORDER BY Sales DESC) AS sales_rank, -- Rank employees by sales within each dept
        EMP_ID, 
        Dept,
        Sales
    FROM Sales
)
SELECT 
    s.total_sales_all_dept, 
    s.total_sales_per_dept, 
    e.ID AS EMP_ID, 
    e.Name, 
    e.Age
FROM sales_rank_per_dpt s
JOIN Employees e ON s.EMP_ID = e.ID
WHERE s.sales_rank = 1
