CREATE database Capstone_Hadoop_RK;

USE Capstone_Hadoop_RK;

##1. A List showing employee number, last_name, first name, sex and salary for each employee.
SELECT 
    e.emp_no, 
    e.last_name, 
    e.sex,
    s.salary
FROM employees e 
INNER JOIN salaries s on s.emp_no = e.emp_no;

##2. A list showing first name, last_name and hire date for employees who were hired in 1986.
select
	first_name,
	last_name,
	hire_date
from employees
where year(to_date(unix_time(unix_timestamp(hire_date, 'dd/MM/yyyy')))) = 1986;

##3. A list showing the manager of each department with the following information: department number, 
##	department name, the manager's employee number, last name, first name.
SELECT 
    d.dept_no, 
    d.dept_name, 
    dm.emp_no, 
    e.last_name, 
    e.first_name
FROM departments d
JOIN department_managers dm
ON d.dept_no = dm.dept_no
JOIN employees e
ON dm.emp_no = e.emp_no;

##4. List the department of each employee with the following information: 
##	employee number, last name, first name, and department name.
SELECT
    de.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM department_employees de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;

##5. A list showing first name, last name, and sex of employees whose first name is 'Hercules'
##	and last name begin with 'B'
SELECT
    first_name,
    last_name,
    sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

##6. A list showing all employees in the Sales department, including their employee number, last name,
##	first name, department name.
SELECT
    de.dept_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM department_employees de
JOIN
employees e on de.emp_no = e.emp_no
JOIN
departments d on de.dept_no = d.dept_no
WHERE d.dept_name = '"Sales"';

##7. A list showing all employees in the sales and development departments including their employee number,
##	last name, first name and department name.
SELECT
    de.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM department_employees de
JOIN
employees e on de.emp_no = e.emp_no
JOIN
departments d on de.dept_no = d.dept_no
WHERE d.dept_name = '"Sales"' OR d.dept_name = '"development"';

##8. A list showing the frequency count of employee last name, in descending order (i.e., how many
##		employees share each last name)
SELECT
    count(last_name) as Frequency
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;