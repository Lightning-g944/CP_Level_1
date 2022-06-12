## AFTER CREATING THE TABLES AND LOADING THE DATA INTO MYSQL TABLES
# RUN THE BELOW SQOOP COMMANDS TO TRANSFER TABLES FROM MYSQL TO HIVE/HDFS INTO AVRO FORMAT

##RUN THE BELOW IN SHELL TO CREATE A FOLDER FOR CAPSTONE DATA FILES
hdfs dfs -mkdir /user/anabig114221/hive/warehouse/EMP_DATA;

##TO IMPORT Department_Employees TABLES
sqoop import --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114221 --username anabig114221 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --table Department_Employees --warehouse-dir=/user/anabig114221/hive/warehouse/EMP_DATA --m 1 --driver com.mysql.jdbc.Driver;

##TO IMPORT Department_Managers TABLES
sqoop import --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114221 --username anabig114221 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --table Department_Managers --warehouse-dir=/user/anabig114221/hive/warehouse/EMP_DATA --m 1 --driver com.mysql.jdbc.Driver;

##TO IMPORT Departments TABLES
sqoop import --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114221 --username anabig114221 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --table Departments --warehouse-dir=/user/anabig114221/hive/warehouse/EMP_DATA --m 1 --driver com.mysql.jdbc.Driver;

##TO IMPORT Salaries TABLES
sqoop import --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114221 --username anabig114221 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --table Salaries --warehouse-dir=/user/anabig114221/hive/warehouse/EMP_DATA --m 1 --driver com.mysql.jdbc.Driver;

##TO IMPORT Titles TABLES
sqoop import --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114221 --username anabig114221 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --table Titles --warehouse-dir=/user/anabig114221/hive/warehouse/EMP_DATA --m 1 --driver com.mysql.jdbc.Driver;

##TO IMPORT Employees TABLES
sqoop import --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114221 --username anabig114221 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --table Employees --warehouse-dir=/user/anabig114221/hive/warehouse/EMP_DATA --driver com.mysql.jdbc.Driver;

##NOW WE NEED TO CREATE A DIRECTORY FOR THE AVRO SCHEMA
hadoop fs -mkdir /user/anabig114221/capstone

hadoop fs -chmod +rw /user/anabig114221/capstone

##WE NEED TO PUT THE AVRO SCHEMA INTO CAPSTONE FOLDER
hadoop fs -put /home/anabig114221/Department_Employees.avsc /user/anabig114221/capstone/Department_Employees.avsc;
hadoop fs -put /home/anabig114221/Department_Managers.avsc /user/anabig114221/capstone/Department_Managers.avsc;
hadoop fs -put /home/anabig114221/Departments.avsc /user/anabig114221/capstone/Departments.avsc
hadoop fs -put /home/anabig114221/Employees.avsc /user/anabig114221/capstone/Employees.avsc
hadoop fs -put /home/anabig114221/Salaries.avsc /user/anabig114221/capstone/Salaries.avsc
hadoop fs -put /home/anabig114221/Titles.avsc /user/anabig114221/capstone/Titles.avsc

##NOW WE CREATE EXTERNAL TABLES IN THE HIVE DATABASE
DROP DATABASE IF EXISTS capstone_hadoop_rk;
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
CREATE EXTERNAL TABLE employees STORED AS AVRO LOCATION '/user/anabig114221/hive/warehouse/EMP_DATA/Employees' 
TBLPROPERTIES ('avro.schema.url' = '/user/anabig114221/capstone/Employees.avsc');