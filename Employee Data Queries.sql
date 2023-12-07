-- Create individual tables + import data

CREATE TABLE Titles (
	id INT PRIMARY KEY,
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(10) NOT NULL
);

CREATE TABLE Departments (
	id INT PRIMARY KEY,
    dept_no VARCHAR(10) NOT NULL,
	dept_name VARCHAR(10) NOT NULL
);

CREATE TABLE Employees_Dept (
	id INT PRIMARY KEY,
    emp_no INT,
	dept_no VARCHAR(10) NOT NULL
);

CREATE TABLE Dept_Managers (
	id INT PRIMARY KEY,
    dept_no VARCHAR(10) NOT NULL,
	emp_no INT
);

CREATE TABLE Employees (
	id INT PRIMARY KEY,
    emp_no INT,
	emp_title VARCHAR(10) NOT NULL,
	birth_date VARCHAR(10) NOT NULL,
	first_name VARCHAR(10) NOT NULL,
	last_name VARCHAR(10) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date VARCHAR(10) NOT NULL
);

CREATE TABLE Salary (
	id INT PRIMARY KEY,
    emp_no INT,
	salary INT
);

SELECT * FROM Employees

-- Combine the tables!
DROP VIEW Employee_sqlv; 
CREATE VIEW Employee_SQLv AS
SELECT
	e.emp_no,
    e.emp_title,
    e.birth_date,
    e.first_name,
    e.last_name,
    e.sex,
    e.hire_date,
    s.salary,
    dm.dept_no AS manager_dept_no,
    ed.dept_no AS employee_dept_no,
    d.dept_name,
    t.title
FROM
    employees AS e
LEFT JOIN
    salary AS s ON e.emp_no = s.emp_no
LEFT JOIN
    dept_managers AS dm ON e.emp_no = dm.emp_no
LEFT JOIN
    employees_dept AS ed ON e.emp_no = ed.emp_no
LEFT JOIN
    departments AS d ON ed.dept_no = d.dept_no
LEFT JOIN
    titles AS t ON e.emp_title = t.title_id;
	
SELECT * FROM Employee_sqlv;

SELECT
	esv.emp_no,
	esv.last_name,
	esv.first_name,
	esv.sex,
	esv.salary
FROM employee_sqlv as esv;

SELECT
	esv.first_name,
	esv.last_name,
	esv.hire_date
FROM employee_sqlv as esv
WHERE hire_date LIKE '%1986';

SELECT
	esv.employee_dept_no,
	esv.dept_name,
	esv.last_name,
	esv.first_name
FROM employee_sqlv as esv
WHERE manager_dept_no IS NOT NULL;

SELECT
	esv.employee_dept_no,
	esv.dept_name,
	esv.emp_no,
	esv.last_name,
	esv.first_name
FROM employee_sqlv as esv;

SELECT
	esv.first_name,
	esv.last_name,
	esv.sex
FROM employee_sqlv as esv
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

SELECT
	esv.dept_name,
	esv.emp_no,
	esv.last_name,
	esv.first_name
FROM employee_sqlv as esv
WHERE dept_name = 'Sales';

SELECT
	esv.dept_name,
	esv.emp_no,
	esv.last_name,
	esv.first_name
FROM employee_sqlv as esv
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

SELECT
    last_name,
COUNT(*) AS frequency
FROM employee_sqlv
GROUP BY last_name
ORDER BY frequency DESC;