-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

drop TABLE dept_manager


CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);



CREATE TABLE salaries (
   	emp_no INT NOT NULL,
  	salary INT NOT NULL,
  	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  	PRIMARY KEY (emp_no)
);

drop TABLE titles

CREATE TABLE titles (
  	emp_no INT NOT NULL,
  	title VARCHAR NOT NULL,
  	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees (emp_no),
  	PRIMARY KEY (emp_no, title, from_date)
);

drop TABLE dept_emp

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


SELECT * FROM departments
SELECT * FROM employees
SELECT * FROM dept_manager
SELECT * FROM salaries
SELECT * FROM titles
SELECT * FROM dept_emp

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--------------------------------------------------CURRENT_EMP
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


--SELECT emp_no, first_name, last_name
--INTO emp_info
--FROM employees
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

----------------------------------------------------EMP_INFO
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
 	AND (de.to_date = '9999-01-01');
---------------------------------------------------------,,,,,,,
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-----------------------------

--SELECT ce.emp_no,
--	ce.first_name,
--	ce.last_name,
--	ti.title,
--	ti.from_date,
--	ti.to_date
--INTO retirement_titles
--FROM current_emp as ce-
--	INNER JOIN titles as ti
--		ON(ce.emp_no = ti.emp_no)
--order BY ti.from_date
------------------------------------TABLE SELECTS
Select * from ret_titles
Select * from current_emp
Select * from titles
Select * from retirement_titles
Select * from retirement_info
Select * from emp_info
Select * from retro_titles

------------------------------------------RETro_TITLES
SELECT em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retro_titles
FROM emp_info as em
	INNER JOIN titles as ti
		ON(em.emp_no = ti.emp_no)
ORDER BY em.emp_no;	
-----------------------------------------------DISTINCT ON ----------------
-- Use Dictinct with Orderby to remove duplicate rows
SELECT distinct on ce.emp_no,
	ce.first_name,
	ce.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO ret_titles
FROM current_emp as ce
	INNER JOIN titles as ti
		ON(ce.emp_no = ti.emp_no)
ORDER BY ce.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) emp_no,
	e.first_name,
	e.last_name,
	ti.title

--INTO nameyourtable
FROM employee as e
--WHERE _______
--ORDER BY _____, _____ DESC;
-------------------
-- quires.sql

SELECT emp_no, first_name, last_name
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');





