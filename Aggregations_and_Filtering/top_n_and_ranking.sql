1. Write an SQL query to find the top 3 customers who spent the most in the last month, along with their total spending.
Tables: transactions (customer_id, amount, transaction_date)
Window Functions

WITH monthly_spending AS(
SELECT customer_id, SUM(amount) as total_spending
FROM transactions
WHERE transaction_date BETWEEN
                            DATE_TRUNC('month',CURRENT_DATE) - INTERVAL '1 month'
                        AND
                            DATE_TRUNC('month',CURRENT_DATE) - INTERVAL '1 day'
GROUP BY customer_id
), with_ranking AS(
SELECT customer_id, 
        total_spending, 
        DENSE_RANK() OVER(ORDER BY total_spending DESC) AS cst_rnk
FROM monthly_spending
)
SELECT total_spending, customer_id
FROM with_ranking
WHERE cst_rnk <=3

2. Write a Query to find the top 5 customers by total order amount in the last year 

Hint: Join two tables on customer_id
join 2 tables on reference key
first have to get last year data
if have to consider ties, out top 5 ranks than dense rank if top 5 rows than row_number

WITH ranked_total_amount AS(
SELECT customer_id, customer_name, dense_rank() over(order by SUM(total_amount) DESC) as rnk
FROM order o
INNER JOIN customer c ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN DATE_TRUNC('year',CURRENT_DATE) - INTERVAL '1 year' AND
                                                DATE_TRUNC('year',CURRENT_DATE) - INTERVAL '1 day'
GROUP BY customer_id, customer_name
)
SELECT customer_id, customer_name
FROM ranked_total_amount
WHERE rnk <= 5


⁠3. Write a SQL Query to find second highest salary using both subqeury and Window functions

Window functions:
WITH salary_ranked AS(
SELECT salary, dense_rank() over(order by salary desc) as rnk
FROM employee
)
SELECT DISTINCT salary
FROM salary_ranked
WHERE rnk = 2

Subquery:
SELECT MAX(salary) as second_highest_salary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee)

4.Write a query to find the rank of employees within each department based on their salary.
Tables: employees (id, name, department_id, salary)
Joins and Subqueries

-- using window functions

SELECT 
    id, name,
    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as employee_rnk
FROM employee

id name department_id salary
1 a 1 100
2 b 1 200 
3 c 3 300
4 d 4 400 
5 e 4 500
6 e 4 400

-- Left Join

a 1 100 1 200
b 1 200 NULL NULL
3 300 NULL NULL
4 400 4 500
4 500 NULL NULL
4 400 4 500

-- using subqueries

SELECT e1.id, e1.name,
        (SELECT COUNT(*) 
        FROM employee e2
        WHERE e1.department_id = e2.department_id AND
            e1.salary > e2.salary) + 1 as employee_rnk
FROM employee e1
ORDER BY department_id, employee_rnk

-- using joins
SELECT department_id, name, COUNT(e2.salary) + 1 AS salary_rnk
FROM employee e1
LEFT JOIN employee e2
            ON e1.department_id = e2.department_id AND
                e1.salary > e2.salary
GROUP BY e1.department_id, e1.name
ORDER BY department_id, salary_rnk

5. Write a Query to find highest purchasing customer with amount from each store on below columns.

cust_id, amount, store_id

considering: store_id, customer_id as primary key meaning no duplicate entries of customer in the same store

WITH cust_ranking_by_store AS(
SELECT cust_id, amount,
    DENSE_RANK() OVER(PARTITION BY store_id ORDER BY amount DESC) as cust_rnk
FROM store
)
SELECT cust_id, amount
FROM cust_ranking_by_store
WHERE cust_rnk = 1

considering: if duplicates of customer ids within the store

WITH total_amount AS(
SELECT cust_id, store_id, SUM(amount) as total_amount
FROM store
GROUP BY cust_id, store_id
), cust_ranking_by_store AS(
SELECT cust_id, total_amount,
    DENSE_RANK() OVER(PARTITION BY store_id ORDER BY total_amount DESC) as cust_rnk
FROM total_amount
)
SELECT cust_id, amount
FROM cust_ranking_by_store
WHERE cust_rnk = 1


