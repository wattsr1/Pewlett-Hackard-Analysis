DROP TABLE current_staff_list;
DROP TABLE employee_titles;

-- Get a list of current employees for PH
SELECT DISTINCT ON (emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO current_staff_list
FROM employees as e
INNER JOIN dept_empl as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

--Show the data
SELECT * FROM current_staff_list

-- Get a total count of employees by title
SELECT COUNT (emp_no), title
INTO employee_titles
FROM current_staff_list as cs
GROUP BY cs.title
ORDER BY count DESC;

-- Show the data
SELECT * FROM employee_titles;

DROP retirement_titles;
-- Titles of retiring employees
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Show the data
SELECT * FROM retirement_titles;

-- Get unique titles for retirement employees
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, 
first_name, 
last_name, 
title
INTO retirement_unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Show the data
SELECT * FROM retirement_unique_titles;

-- Show the number of retirees by title
SELECT COUNT (emp_no), title
INTO retiring_titles
FROM retirement_unique_titles as rt
GROUP BY rt.title
ORDER BY count DESC;

--Show the data
SELECT * FROM retiring_titles;

DROP TABLE mentorship_eligibility;
-- Get list of eligible mentorship employees
SELECT DISTINCT ON (emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title	
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_empl as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

--Show the data
SELECT * FROM mentorship_eligibility;

DROP TABLE mentorship_titles;
--Show the count of elibible employees for mentorship by title
SELECT COUNT (emp_no), title
INTO mentorship_titles
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY count DESC;

--Show the data
SELECT * FROM mentorship_titles;

-- Added Queries for further analysis beyond
-- assignment scope

DROP TABLE retirement_titles_current;

-- Titles of retiring employees currently working
SELECT DISTINCT ON (emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	de.from_date,
	de.to_date
INTO retirement_titles_current
FROM employees as e
INNER JOIN dept_empl as de
on (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

--Show the data
SELECT * FROM retirement_titles_current;

--DROP TABLE retirement_current_titles;

--Show the count of employees currently working that
--are eligible for retirement by title
SELECT COUNT (emp_no), title
INTO retirement_current_titles
FROM retirement_titles_current as rt
GROUP BY rt.title
ORDER BY count DESC;

--Show the data
SELECT * FROM retirement_current_titles;

DROP TABLE ext_mentorship_eligibility;

-- Get list of extended eligible mentorship employees
SELECT DISTINCT ON (emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title	
INTO ext_mentorship_eligibility
FROM employees as e
INNER JOIN dept_empl as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1963-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

--Show the data
SELECT * FROM ext_mentorship_eligibility;

DROP TABLE mentorship_titles;
--Show the count of elibible employees for mentorship by title
SELECT COUNT (emp_no), title
INTO ext_mentorship_titles
FROM ext_mentorship_eligibility as me
GROUP BY me.title
ORDER BY count DESC;

--Show the data
SELECT * FROM ext_mentorship_titles;
