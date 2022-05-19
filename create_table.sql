use anabig114221;

DROP TABLE IF EXISTS Titles;

CREATE TABLE Titles(
    title_id varchar(10)  NOT NULL,
    title varchar(20)  NOT NULL,
    PRIMARY KEY (title_id)
);

DROP TABLE IF EXISTS Employees;

create table Employees(
    emp_no int, 
	emp_title_id varchar(50), 
	birth_date varchar(50), 
	first_name varchar(50), 
	last_name varchar(50), 
	sex varchar(50),
	hire_date varchar(50), 
	no_of_projects int, 
	last_performance_ratings varchar(50),
	left1 boolean, 
	last_date varchar(50), 
	primary key(emp_no)
);


DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries(
    emp_no int NOT NULL ,
    salary bigint NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

DROP TABLE IF EXISTS Department_Managers;

CREATE TABLE Department_Managers(
    dept_no varchar(10) NOT NULL ,
    emp_no int NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments(
    dept_no varchar(10) NOT NULL ,
    dept_name VARCHAR(20) NOT NULL ,
    PRIMARY KEY(dept_no)
);


DROP TABLE IF EXISTS Department_Employees;

CREATE TABLE Department_Employees(
    emp_no int  NOT NULL,
    dept_no varchar(10)  NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

ALTER TABLE `Department_Managers` ADD CONSTRAINT `fk_Department_Managers_dept_no` FOREIGN KEY(`dept_no`)
REFERENCES `Departments` (`dept_no`);

ALTER TABLE `Department_Employees` ADD CONSTRAINT `fk_Department_Employees_dept_no` FOREIGN KEY(`dept_no`)
REFERENCES `Departments` (`dept_no`);