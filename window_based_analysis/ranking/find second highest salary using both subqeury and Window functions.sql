
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

4. Write SQL query to get the nth highest salary in a specific department

WITH salary_ranking AS(
SELECT department_id,
        department_name,
        salary,
        dense_rank() OVER(
                            PARTITION BY department_id
                            ORDER BY salary desc
                        ) AS salary_rank
FROM departments
)
SELECT department_id, department_name, salary as nth_highest_salary
FROM salary_ranking
WHERE deparment_id = x AND salary_rank = n
