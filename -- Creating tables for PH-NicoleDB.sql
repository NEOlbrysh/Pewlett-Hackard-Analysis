-- Creating tables for PH-NicoleDB

CREATE TABLE departments (
     dept_no VARCHAR NOT NULL,
     dept_name VARCHAR NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);


CREATE TABLE Employees(
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE Managers (
dept_no VARCHAR NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
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

CREATE TABLE title (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp (
 emp_no INT NOT NULL,
 dept_no VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
  
SELECT * FROM Departments
SELECT * FROM Employees

DROP TABLE departments CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE managers CASCADE;
DROP TABLE salaries CASCADE;
DROP TABLE title CASCADE;


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

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

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;
DROP TABLE emp_info;
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

--------------------------------------------------------------------------------------

-- Joining departments and managers tables
SELECT departments.dept_name,
     managers.emp_no,
     managers.from_date,
     managers.to_date
FROM departments
INNER JOIN managers
ON departments.dept_no = managers.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
   dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

DROP TABLE current_emp;

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
INNER JOIN managers as dm
ON d.dept_no = dm.dept_no;

DROP TABLE current_emp;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
-----------------------------------------------------------------------------------------

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

---------------------------------------------------------------------------------------

SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT emp_no,
    first_name,
last_name,
    gender
--INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');	

SELECT e.emp_no,
    e.first_name,
e.last_name,
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
		  
DROP TABLE emp_info;		  
		  
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM managers AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);	
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);








----------------------------------------------------------------------------------------
-- Deliverable 1
-- 1. Retrieve the emp_no, first name, and last name columns from the Employees table.
SELECT emp_no, last_name, first_name
FROM employees
LIMIT (10);

-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM Title
LIMIT (10);

-- 3. Create a new table using the INTO clause.
SELECT title, from_date, to_date, emp_no
INTO retirement_titles
FROM Title;

DROP TABLE retirement_titles
SELECT * FROM retirement_titles
SELECT * FROM employees

-- 4 Join both tables on the primary key. 
SELECT * FROM employees
INNER JOIN retirement_titles ON employees.emp_no = retirement_titles.emp_no
LIMIT (10);
 

-- 5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. 
-- Then, order by the employee number.
SELECT employees.emp_no AS Employee_Number, employees.last_name, employees.first_name, employees.birth_date
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC
LIMIT (10);


-- 8. 
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) employees.emp_no,
employees.first_name,
employees.last_name,
retirement_titles.title

INTO unique_titles
FROM employees, retirement_titles
ORDER BY emp_no, title DESC;

-- 9. Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
SELECT emp_no, first_name, last_name, title
FROM retirement_titles
LIMIT (10);
SELECT * 
FROM employees
LIMIT (10);
-- 10. Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of 
-- rows defined by the ON () clause.

SELECT DISTINCT ON (emp_no) emp_no
FROM retirement_titles
LIMIT (10);

-- 11. Exclude those employees that have already left the company by filtering on to_date to keep only those 
-- dates that are equal to '9999-01-01'.
SELECT emp_no, first_name, last_name, title, to_date
FROM retirement_titles
WHERE (to_date = '9999-01-01')
LIMIT(10);

-- 12. Create a Unique Titles table using the INTO clause.
SELECT emp_no, first_name, last_name, title, to_date
INTO Unique_titles
FROM retirement_titles;

SELECT * FROM Unique_titles

-- 13. Sort the Unique Titles table in ascending order by the employee number and descending order 
-- by the last date (i.e., to_date) of the most recent title.
SELECT emp_no, title
FROM Unique_titles
ORDER BY emp_no ASC, to_date DESC;

-- 16. Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees 
-- by their most recent job title who are about to retire.
SELECT emp_no, first_name, last_name, title, to_date
FROM Unique_titles
ORDER BY title DESC
LIMIT (10);


--17. First, retrieve the number of titles from the Unique Titles table.
SELECT titles
FROM Unique_titles
LIMIT (10);

-- 18. Then, create a Retiring Titles table to hold the required information.
SELECT titles, to_date
FROM Unique_tiles
INTO Retiring_titles
LIMIT (10);


-- 19. Group the table by title, then sort the count column in descending order.
SELECT COUNT titles
FROM Retiring_titles
ORDER BY title DESC
LIMIT (10);

SELECT * FROM Retiring_titles


-----------------------------------------------------------------------------------------------------------------

-- Deliverable 2
-- 1. Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
SELECT employees.emp_no AS Employee_Number, employees.last_name, employees.first_name
FROM employees
LIMIT (10);

-- 2. Retrieve the from_date and to_date columns from the Department Employee table.
SELECT dept_emp.from_date, dept_emp.to_date
FROM dept_emp
LIMIT (10);

SELECT * FROM dept_emp


-- 3. Retrieve the title column from the Title table.
SELECT title
FROM title
LIMIT (10);

-- 4. Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows 
-- defined by the ON () clause. 
SELECT DISTINCT ON (emp_no) emp_no
FROM dept_emp
LIMIT (10);

-- 5. Create a new table using the INTO clause. 
SELECT emp_no, dept_no, from_date, to_date
INTO mentorship_eligibilty
FROM dept_emp;


SELECT * FROM mentorship_eligibilty

-- 6. Join the Employees and the Department Employee tables on the primary key. 
-- 7. Join the Employees and the Titles tables on the primary key. 
SELECT employees.emp_no AS Employee_Number, employees.last_name, employees.first_name, employees.birth_date
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN title
ON employees.emp_no = title.emp_no
LIMIT (10);

SELECT employees.emp_no AS Employee_Number, employees.last_name, employees.first_name, employees.birth_date
FROM employees
JOIN title
ON employees.emp_no = title.emp_no
LIMIT (10);

-- 8. Filter the data on the to_date column to all the current employees, then filter the data on the 
--birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
-- 9. Order the table by the employee number.
SELECT emp_no, first_name, last_name, to_date, birth_date
FROM retirement_titles
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND
WHERE (to_date = '9999-01-01')
ORDER BY emp_no
LIMIT (10);


