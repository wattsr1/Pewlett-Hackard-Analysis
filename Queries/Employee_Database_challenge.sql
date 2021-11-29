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

--Show the count of elibible employees for mentorship by title
SELECT COUNT (emp_no), title
INTO mentorship_titles
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY count DESC;

--Show the data
SELECT * FROM mentorship_titles;