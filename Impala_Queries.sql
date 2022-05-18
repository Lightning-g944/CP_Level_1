CREATE database Capstone_Hadoop_RK;

USE Capstone_Hadoop_RK;

--1. A List showing employee number, last_name, first name, sex and salary for each employee.
SELECT 
    e.emp_no, 
    e.last_name, 
    e.sex,
    s.salary
FROM employees e 
INNER JOIN salaries s on s.emp_no = e.emp_no;

--2. A list showing first name, last_name and hire date for employees who were hired in 1986.
select
	first_name,
	last_name,
	hire_date
from employees
where year(to_date(unix_time(unix_timestamp(hire_date, 'dd/MM/yyyy')))) = 1986;

--3. A list showing the manager of each department with the following information: department number, 
--	department name, the manager's employee number, last name, first name.
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

--4. List the department of each employee with the following information: 
--	employee number, last name, first name, and department name.
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

--5. A list showing first name, last name, and sex of employees whose first name is 'Hercules'
--	and last name begin with 'B'
SELECT
    first_name,
    last_name,
    sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

--6. A list showing all employees in the Sales department, including their employee number, last name,
--	first name, department name.
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

--7. A list showing all employees in the sales and development departments including their employee number,
--	last name, first name and department name.
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

--8. A list showing the frequency count of employee last name, in descending order (i.e., how many
--		employees share each last name)
SELECT
	last_name,
    count(last_name) as Frequency
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;

--9. Histogram to show the salary distribution among the employee.

CREATE view BINS as
SELECT
    CASE 
        WHEN s.salary >= 40000 and s.salary < 50000 THEN '40k-50k'
        WHEN s.salary >= 50000 and s.salary <60000 THEN '50k-60k'
        WHEN s.salary >= 60000 and s.salary < 70000 THEN '60k-70k'
        WHEN s.salary >= 70000 and s.salary < 80000 THEN '70k-80k'
        WHEN s.salary >= 80000 and s.salary < 90000 THEN '80k-90k'
        WHEN s.salary >= 90000 and s.salary < 100000 THEN '90k-100k'
        WHEN s.salary >= 100000 and s.salary < 110000 THEN '100k-110k'
        WHEN s.salary >= 110000 and s.salary < 120000 THEN '110k-120k'
        WHEN s.salary >= 120000 and s.salary < 130000 THEN '120k-130k'
        ELSE 'NA'
        END as Bins
FROM employees e
JOIN salaries s
on s.emp_no = e.emp_no;

SELECT 
    bins,
    count(bins) as salary_range
from bins
GROUP BY bins
ORDER BY salary_range DESC;

--10. Bar graph to show Avg salary per title (designation)

SELECT
    t.title,
    avg(s.salary) as Avg_Salary
FROM employees e
JOIN titles t
ON t.title_id = e.emp_title_id
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY t.title;

--11. Calculate employee tenure and show tenure distribution among the employees.

CREATE table Employees_final as
SELECT
    emp_no as emp_no,
    emp_title_id as emp_title_id,
    cast(concat(substring_index((substring_index(birth_date,'/',3)),'/',-1),'-',
            substring_index((substring_index(birth_date,'/',1)),'/',-1),'-',
            substring_index((substring_index(birth_date,'/',2)),'/',-1)) as DATE) as birth_date,
    first_name as first_name,
    last_name as last_name,
    sex as sex,
    cast(concat(substring_index((substring_index(hire_date,'/',3)),'/',-1),'-',
            substring_index((substring_index(hire_date,'/',1)),'/',-1),'-',
            substring_index((substring_index(hire_date,'/',2)),'/',-1)) as DATE) as hire_date,
    no_of_projects as no_of_projects,
    last_performance_ratings as last_performance_ratings,
    cast(left1 as int) as left_,
     cast(concat(substring_index((substring_index(last_date,'/',3)),'/',-1),'-',
            substring_index((substring_index(last_date,'/',1)),'/',-1),'-',
            substring_index((substring_index(last_date,'/',2)),'/',-1)) as DATE) as last_date
from employees;

SELECT
    emp_no,
    first_name,
    last_name,
    2000-year(hire_date) as tenure
FROM emp_final
order by tenure desc

    SELECT
    e.emp_no,
        CASE
            WHEN 2000-year(hire_date) <= 15 AND 2000-year(hire_date) >=10 THEN '10+ years exp'
            WHEN 2000-year(hire_date) <= 10 AND 2000-year(hire_date) >=5 THEN '5-10 years exp'
            WHEN 2000-year(hire_date) <= 5  AND 2000-year(hire_date) >=1 THEN '1-5 years exp'
            ELSE 'FRESHER'
            END as Experience
        FROM emp_final e
JOIN capstone_hadoop_rk.titles t
ON t.title_id = e.emp_title_id
  
  