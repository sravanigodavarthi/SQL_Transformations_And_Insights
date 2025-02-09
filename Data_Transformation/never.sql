
Retrieve the names of employees who have never made a sale.
Tables: employees (id, name), sales (sale_id, employee_id, amount)

Data Transformation

-- subqueries

SELECT e.name
FROM employees e
WHERE NOT EXISTS(SELECT 1 FROM sales s WHERE e.id = s.employee_id)

-- joins

SELECT e.name
FROM employees e
LEFT JOIN sales s ON
            e.id = s.employee_id
WHERE s.employee_id IS NULL


List customers who have not placed any orders

SELECT c.customer_id
FROM customer o 
LEFT JOIN orders c ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL

