
DROP DATABASE IF EXISTS capstone_hadoop_rkl
CREATE DATABASE capstone_hadoop_rk;

USE capstone_hadoop_rk;

DROP TABLE IF EXISTS titles;
CREATE EXTERNAL TABLE titles STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Titles' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Titles.avsc');

DROP TABLE IF EXISTS Department_Employees;
CREATE EXTERNAL TABLE Department_Employees STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Department_Employees' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Department_Employees.avsc');

DROP TABLE IF EXISTS Department_Managers;
CREATE EXTERNAL TABLE Department_Managers STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Department_Managers' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Department_Managers.avsc');

DROP TABLE IF EXISTS Departments;
CREATE EXTERNAL TABLE Departments STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Departments' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Departments.avsc');

DROP TABLE IF EXISTS Salaries;
CREATE EXTERNAL TABLE Salaries STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Salaries' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Salaries.avsc');

DROP TABLE IF EXISTS employees;
CREATE EXTERNAL TABLE employees STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Employees_1' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Employees_1.avsc');