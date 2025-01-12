
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