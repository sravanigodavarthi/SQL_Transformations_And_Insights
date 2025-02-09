Retrieve employees with the same salary

SELECT employee, salary
FROM employee 
GROUP BY salary
HAVING COUNT(employee_id) > 1