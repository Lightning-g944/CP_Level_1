# Data Engineering - Capstone End to End Pipeline

### CREATION OF MYSQL TABLES AND LOADING DATA INTO TABLES

##### To Create SQL Tables with schema run the following command in shell
`mysql -u anabig114221 -pBigdata123 create_table.sql`

#### To load the csv files into the created table schema, run load_csv.sql in shell
`mysql -u anabig114221-pBigdata123 load_csv.sql`

### SQOOP COMMANDS TO IMPORT TABLES INTO HIVE AND SAVE AS AVRO FILES
##### Run below commands in shell to import all tables as avro into HDFS
##### Below file also create a warehouse dir to store the data files and 
##### the same dir is used to create the tables in hive.
`sh sqoop_import_as_avro.sh`

#### Run below file in hive shell to drop existing tables and create new database using the avro data which was imported into HDFS via sqoop.  
`hive -f hive_create_table.sql`

#### For EDA Analysis in Impala run the commands in Impala or Impala-shell

`CREATE database Capstone_Hadoop_RK;`

`USE Capstone_Hadoop_RK;`

#####1. A List showing employee number, last_name, first name, sex and salary for each employee.
```SELECT 
    e.emp_no, 
    e.last_name, 
    e.sex,
    s.salary
FROM employees e 
INNER JOIN salaries s on s.emp_no = e.emp_no;```

#####2. A list showing first name, last_name and hire date for employees who were hired in 1986.
```select
	first_name,
	last_name,
	hire_date
from employees
where year(to_date(unix_time(unix_timestamp(hire_date, 'dd/MM/yyyy')))) = 1986;```

#####3. A list showing the manager of each department with the following information: department number, 
#####	department name, the manager's employee number, last name, first name.
```SELECT 
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
```
#####4. List the department of each employee with the following information: 
#####	employee number, last name, first name, and department name.
```SELECT
    de.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM department_employees de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;
```
#####5. A list showing first name, last name, and sex of employees whose first name is 'Hercules'
#####	and last name begin with 'B'
```SELECT
    first_name,
    last_name,
    sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';
```
#####6. A list showing all employees in the Sales department, including their employee number, last name,
#####	first name, department name.
```SELECT
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
```
#####7. A list showing all employees in the sales and development departments including their employee number,
#####	last name, first name and department name.
```SELECT
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
```
#####8. A list showing the frequency count of employee last name, in descending order (i.e., how many
#####		employees share each last name)
```SELECT
	last_name,
    count(last_name) as Frequency
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;
```
#####9. Histogram to show the salary distribution among the employee.
```
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
```
```SELECT 
    bins,
    count(bins) as salary_range
from bins
GROUP BY bins
ORDER BY salary_range DESC;
```
#####10. Bar graph to show Avg salary per title (designation)
```
SELECT
    t.title,
    avg(s.salary) as Avg_Salary
FROM employees e
JOIN titles t
ON t.title_id = e.emp_title_id
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY t.title;
```
#####11. Calculate employee tenure and show tenure distribution among the employees.
```
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
```
```SELECT
    emp_no,
    first_name,
    last_name,
    2000-year(hire_date) as tenure
FROM employees_final
order by tenure desc;
```
``` SELECT
    e.emp_no,
        CASE
            WHEN 2000-year(hire_date) <= 15 AND 2000-year(hire_date) >=10 THEN '10+ years exp'
            WHEN 2000-year(hire_date) <= 10 AND 2000-year(hire_date) >=5 THEN '5-10 years exp'
            WHEN 2000-year(hire_date) <= 5  AND 2000-year(hire_date) >=1 THEN '1-5 years exp'
            ELSE 'FRESHER'
            END as Experience
        FROM employees_final e
JOIN capstone_hadoop_rk.titles t
ON t.title_id = e.emp_title_id;```

#### 12. Addition Analysis

##### 1. The tenure for each Title
```
SELECT
    t.title,
    2000-year(e.hire_date) as tenure
FROM employees_final e
JOIN titles t
ON t.title_id = e.emp_title_id
GROUP BY tenure, t.title 
order by tenure desc;```

##### 2. Employees left the organization and there respective Tenure and Title when they left
```
select
    t.title,
    e.emp_no as Employees_left,
    2000-year(e.hire_date) as Tenure
    from employees_final e
    inner join titles t
    on t.title_id = e.emp_title_id
    where left_ = 1;
```
##### 3. Total number of projects in every department
```
select
        d.dept_name,
        sum(no_of_projects) as Total_Projects
    from employees_final e
    inner join department_employees de
    on e.emp_no = de.emp_no
    inner join departments d
    on d.dept_no = de.dept_no
    group by d.dept_name
    order by Total_Projects desc;
```	
##### 4. Number of Employees who left in the last 5 year

`select max(year(last_date)) from employees_final;`
```
select
    count(e.emp_no) as Employees_left_in_5_yrs
    from employees_final e
    inner join titles t
    on t.title_id = e.emp_title_id
    where left_ = 1 and year(e.last_date) >= 2009;
```	
##### 5. Number of Employees in each rating category
```
select
    last_performance_ratings as rating,
    count(emp_no) as No_of_employees
from emp_final
group by rating
order by No_of_employees;
```

```select
    last_performance_ratings as rating,
    count(emp_no) as No_of_employees,
    sex
from emp_final
group by rating, sex
order by No_of_employees;```

#### you can run same commands in spark with the following syntax
Importing packages
```
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName('Project').getorCreate()
```
Run in below syntax
`spark.sql("""select * from employees""").show()`

for spark EDA and spark ML check their respective folders for jupyternote book files