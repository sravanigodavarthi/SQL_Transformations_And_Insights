Retrieve employees who earn more than the average salary

SELECT employee_id, salary
FROM employee
WHERE salary > (SELECT MAX(salary) FROM employee)