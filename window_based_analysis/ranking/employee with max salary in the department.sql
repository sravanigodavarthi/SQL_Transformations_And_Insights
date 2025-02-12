Employee with the max salary in the department?

id employee_name salary manager depid
1 john 1000 4 10
2 bill 4000 6 100
3 max 2000 6 1
4 sam 3000 5 10
5 pam 5000 2 100
6 sundar 10000 Null 1

WITH ranked_salary AS(
    SELECT employee_name, depid, salary,
            DENSE_RANK() OVER(PARTITION BY depid ORDER BY salary DESC) AS salary_rnk
    FROM Employee
)
SELECT employee_name, depid, salary AS max_salary
FROM ranked_salary
WHERE salary_rnk = 1


