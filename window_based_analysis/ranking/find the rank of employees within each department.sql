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