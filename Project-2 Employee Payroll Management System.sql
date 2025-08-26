-- create a database named payroll_database
CREATE DATABASE payroll_database;
USE payroll_database;

-- Create a table employees with columns: EMPLOYEE_ID (integer), NAME (text), DEPARTMENT (text), EMAIL (text), PHONE_NO (numeric), JOINING_DATE (date), SALARY (numeric), BONUS (numeric), TAX_PERCENTAGE (numeric). 

CREATE DATABASE payroll_database;
USE payroll_database;
 CREATE TABLE employees (
 EMPLOYEE_ID INT PRIMARY KEY,
 NAME TEXT NOT NULL,
 DEPARTMENT TEXT NOT NULL,
 EMAIL TEXT NOT NULL,
 PHONE_NO NUMERIC NOT NULL,
 JOINING_DATE DATE,
 SALARY NUMERIC,
 BONUS NUMERIC,
 TAX_PERCENTAGE NUMERIC
);

-- Insert 10 sample employee records
INSERT INTO employees VALUES
(1, 'Allan', 'Sales', 'allan@gmail.com', 9904567890, '2025-04-10', 75000, 8000, 10),
(2, 'Carol', 'IT', 'carol@gamil.com', 9345678901, '2023-08-12', 95000, 5000, 12),
(3, 'Whilson', 'HR', 'whilson@gmail.com', 7356789012, '2025-03-20', 60000, 3000, 8),
(4, 'David', 'Finance', 'david@gmail.com', 9667890123, '2024-12-01', 88000, 7000, 15),
(5, 'Eva', 'Sales', 'eva@gmail.com', 9678901234, '2025-06-05', 72000, 6000, 9),
(6, 'Frank', 'IT', 'frank@gmail.com', 7789012345, '2023-11-30', 105000, 10000, 18),
(7, 'Grace', 'HR', 'grace@gmail.com', 7390123456, '2025-08-01', 68000, 2000, 7),
(8, 'Henry', 'Finance', 'henry@gmail.com', 9901234567, '2024-01-15', 99000, 5000, 14),
(9, 'Thomas', 'Sales', 'thomas@gmail.com', 9012345678, '2025-05-20', 76000, 8500, 10),
(10, 'Jack', 'IT', 'jack@gmail.com', 9923456789, '2025-02-28', 97000, 4000, 11),
(11, 'Joe', 'Sales', 'Joe@gmail.com', 9704567890, '2025-04-10', 75000, 8000, 10);

-- Payroll Queries

-- Retrieve the list of employees sorted by salary in descending order
SELECT * FROM employees
ORDER BY SALARY DESC;

-- Find employees with a total compensation (SALARY + BONUS) greater than $100,000
SELECT * FROM employees
WHERE (SALARY + BONUS) > 100000;

-- Update the bonus for employees in the ‘Sales’ department by 10%
UPDATE employees
SET BONUS = BONUS * 1.10
WHERE DEPARTMENT = 'Sales';
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, BONUS
FROM employees
WHERE DEPARTMENT = 'Sales';

-- Calculate the net salary after deducting tax for all employees
SELECT 
NAME, 
SALARY, 
BONUS, 
TAX_PERCENTAGE,
ROUND((SALARY + BONUS) * (1 - TAX_PERCENTAGE / 100.0), 2) AS NET_SALARY
FROM 
employees
ORDER BY 
NET_SALARY DESC;

-- Retrieve the average, minimum, and maximum salary per department
SELECT DEPARTMENT,
ROUND(AVG(SALARY),0) AS AVERAGE_SALARY,
MIN(SALARY) AS MIN_SALARY,
MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT;

-- Advanced Queries
-- Retrieve employees who joined in the last 6 months

SELECT * FROM employees
WHERE JOINING_DATE >= CURDATE() - INTERVAL 6 MONTH;

-- Group employees by department and count how many employees each has
SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
FROM employees
GROUP BY DEPARTMENT;

-- Find the department with the highest average salary
SELECT 
DEPARTMENT,
Round(AVG(SALARY),0) as AVG_SALARY
FROM employees
GROUP BY DEPARTMENT
ORDER BY AVG_SALARY DESC
LIMIT 1;

-- Identify employees who have the same salary as at least one other employee
SELECT * FROM employees
WHERE SALARY IN (
SELECT SALARY
FROM employees
GROUP BY SALARY
HAVING COUNT(*) > 1
);