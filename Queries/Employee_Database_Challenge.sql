SELECT *
FROM employees

SELECT *
FROM departments

SELECT *
FROM dept_emp

SELECT *
FROM manager_info

SELECT *
FROM titles

--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT employees.emp_no AS Employee_Number, employees.last_name, employees.first_name
FROM employees

--Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT titles.title AS Employee_Title, titles.from_date, titles.to_date
FROM titles

--Create a new table using the INTO clause.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	titles.from_date,
	titles.to_date,
	titles.title
INTO retirement_title
FROM employees
--Join both tables on the primary key.
	inner join titles
		ON (titles.emp_no = employees.emp_no)
		
--Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

ORDER BY emp_no, emp_no DESC;

--Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
select *
from retirement_title
where (to_date = '9999-01-01')

--Create a Unique Titles table using the INTO clause.
SELECT emp_no, first_name, last_name, title
INTO Unique_Titles
FROM retirement_title

--Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
ORDER BY emp_no ASC, from_date DESC;

SELECT *
FROM unique_titles


--First, retrieve the number of titles from the Unique Titles table.
--Then, create a Retiring Titles table to hold the required information.
--Group the table by title, then sort the count column in descending order.
--Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
SELECT COUNT(unique_titles.title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY count DESC;

SELECT * 
FROM retiring_titles

--D2
--Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
SELECT employees.emp_no AS Employee_Number, employees.last_name, employees.first_name, employees.birth_date
FROM employees

--Retrieve the from_date and to_date columns from the Department Employee table.
SELECT dept_emp.from_date AS dept_emp, dept_emp.to_date 
FROM dept_emp

--Retrieve the title column from the Titles table.
SELECT titles.title AS title
FROM titles

--Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
--Create a new table using the INTO clause.

SELECT DISTINCT ON (emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_eligibilty
FROM employees

--Join the Employees and the Department Employee tables on the primary key.
--Join the Employees and the Titles tables on the primary key.
--Join both tables on the primary key.
	inner join titles
		ON (titles.emp_no = employees.emp_no)
	INNER JOIN dept_emp
		ON (employees.emp_no = dept_emp.emp_no)
--Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')

--Order the table by the employee number.
ORDER BY emp_no, emp_no DESC;

--Export the Mentorship Eligibility table as mentorship_eligibilty.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

SELECT *
FROM mentorship_eligibility

-- Added query for additional information
SELECT COUNT(mentorship_eligibility.title), mentorship_eligibility.title
INTO mentorship
FROM mentorship_eligibility
GROUP BY mentorship_eligibility.title
ORDER BY count DESC;

select *
from mentorship
