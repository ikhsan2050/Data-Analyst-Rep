CREATE DATABASE HR_086;
USE HR_086;

SHOW TABLES

-- No 1
SELECT a.First_Name AS Employee_Name, a.Last_Name AS Employee_Name, b.Job_ID, b.Job_Title, b.Max_Salary
FROM employees a
NATURAL JOIN jobs b
WHERE a.Department_ID > 80;

SELECT CONCAT(a.First_Name, ' ', a.last_Name) AS Employee_Name, b.Job_ID, b.Job_Title, b.Max_Salary
FROM employees a
NATURAL JOIN jobs b
WHERE a.Department_ID > 80;

-- No 2
SELECT a.First_Name AS Employee_Name, a.Last_Name AS Employee_Name, d.country_Name
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
INNER JOIN locations c ON c.location_ID = b.location_ID
INNER JOIN countries d ON d.country_ID = c.country_ID;

SELECT CONCAT(a.First_Name, ' ',a.last_Name) AS Employee_Name, d.country_Name
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
INNER JOIN locations c ON c.location_ID = b.location_ID
INNER JOIN countries d ON d.country_ID = c.country_ID;

-- No 3
SELECT CONCAT(a.First_Name, ' ', a.Last_Name) AS Employee_Name, a.Job_ID, a.Salary
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
INNER JOIN locations c ON c.location_ID = b.location_ID
WHERE c.city = 'London';

-- No 4
SELECT b.employee_ID, b.start_Date, b.end_Date, b.Job_ID, b.Department_ID, a.Salary
FROM job_history b
INNER JOIN  employees a ON a.employee_ID = b.employee_ID
WHERE a.Salary < 12000 AND b.department_ID IN ('30', '80')

SELECT e.employee_ID, j.start_Date, j.end_Date, j.job_ID, e.department_ID, e.Salary
FROM employees e
JOIN job_history j ON j.employee_ID = e.employee_ID
WHERE e.Salary < 12000 AND e.department_ID IN ('30', '80')

-- No 5
SELECT d.department_Name, CONCAT(a.first_Name, ' ', a.last_Name) AS name_of_manager, b.city
FROM employees a
INNER JOIN departments d ON a.employee_ID = d.manager_ID
INNER JOIN locations b ON b.location_ID = d.location_ID
WHERE b.city LIKE '%s%'

-- No 6
SELECT a.department_ID, b.department_Name, AVG(a.Salary) AS avg_salary_086
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
AND a.department_ID NOT IN ('100', '110', '90')
GROUP BY a.department_ID
HAVING avg_salary_086 > 5000
ORDER BY avg_salary_086 DESC;

SELECT a.department_ID, b.department_Name, AVG(a.Salary) AS avg_salary_086, a.job_ID, CONCAT(a.first_Name, ' ', a.last_Name) AS Employee_Name
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
INNER JOIN jobs j ON a.job_id = j.job_id
WHERE a.job_id LIKE '%rep%'
AND a.department_ID IN ('100', '70', '20')
GROUP BY a.department_ID
HAVING avg_salary_086 > 5000
ORDER BY avg_salary_086 DESC;

-- No 7
SELECT CONCAT(b.first_Name, ' ', b.last_Name) AS Nama_Pegawai, b.employee_ID, a.job_ID, a.job_Title, a.max_Salary AS max_salary_086, l.city, r.region_Name
FROM jobs a
JOIN employees b ON b.job_id = a.job_id
JOIN departments d ON d.department_id = b.department_id
JOIN locations l ON l.location_id = d.location_ID
JOIN countries c ON c.country_id = l.country_id
JOIN regions r ON r.region_id = c.region_id
WHERE a.max_Salary < 10000
AND a.job_ID NOT LIKE '%REP%';

-- No 8
SELECT a.department_ID, b.department_Name, MIN(a.hire_Date) AS min_hire_086, MAX(a.hire_Date) AS max_hire_086
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
GROUP BY b.department_ID;

SELECT CONCAT(a.first_Name, ' ', a.last_Name) AS employee_Name, a.employee_ID, a.department_ID, b.department_Name, MIN(a.hire_Date) AS min_hire_086, MAX(a.hire_Date) AS max_hire_086, l.city, r.region_Name
FROM employees a
JOIN departments b USING (department_ID)
JOIN locations l USING (location_id)
JOIN countries c USING (country_id)
JOIN regions r USING (region_ID)
GROUP BY b.department_ID;

-- No 9
SELECT c.city, c.state_Province, d.country_Name, COUNT(a.employee_ID) AS sum_emp_086
FROM employees a
INNER JOIN departments b ON b.department_ID = a.department_ID
INNER JOIN locations c ON c.location_ID = b.location_ID
INNER JOIN countries d ON d.country_ID = c.country_ID
WHERE c.state_Province IS NOT NULL
GROUP BY c.city
ORDER BY sum_emp_086 DESC;

-- No 10
SELECT c.job_ID, c.job_Title, AVG(b.Salary) AS avg_086, COUNT(b.employee_ID) AS count_emp_086
FROM employees b
INNER JOIN jobs c ON c.job_ID = b.job_ID
GROUP BY c.JOB_ID
HAVING avg_086 > 3000 AND count_emp_086 BETWEEN '10' AND '50'

SELECT * FROM locations
SELECT * FROM departments
SELECT * FROM job_history
SELECT * FROM employees
SELECT * FROM locations
SELECT * FROM jobs
