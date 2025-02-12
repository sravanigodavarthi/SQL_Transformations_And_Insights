
id employee_name salary manager depid
1 john 1000 4 10
2 bill 4000 6 100
3 max 2000 6 1
4 sam 3000 5 10
5 pam 5000 2 100
6 sundar 10000 Null 1

Employee who earns more than manager?
SELECT employee_name
FROM Employee e1
INNER JOIN Employee e2 ON e1.manager = e2.id
WHERE e1.salary > e2.salary