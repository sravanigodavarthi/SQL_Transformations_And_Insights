Write a query to select projects with the highest budget-per-employee ratio from two related tables (projects and employees).

what is the relation between 2 tables, 
each project can be assigned to one or more employees: so one to many cardinality
each employee can be be assigned to one or more projects?


projects

project_id name budget
1 a 1000
2 b 2000
3 c 3000
4 d 4000

employees-project table
employee_id project_id
101  1 
101  2
102  1
103  2
104  3
104  4
103  1


WITH budget_per_employee_ratio AS(
SELECT project_id, ROUND(budget/(1.0*COUNT(employee_id)),2) as budget_ratio 
FROM employees_project ep 
JOIN projects p ON ep.project_id = p.project_id
GROUP BY project_id, budget
), second_highest AS(
SELECT project_id, DENSE_RANK() OVER(ORDER BY budget_ratio) as budget_rnk
FROM budget_per_employee_ratio
)
SELECT project_id as highest_budget
FROM second_highest
WHERE budget_rnk = 1
