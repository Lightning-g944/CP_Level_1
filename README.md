# Data Engineering - Capstone End to End Pipeline

### CREATION OF MYSQL TABLES AND LOADING DATA INTO TABLES

##### To Create SQL Tables with schema run the following command in shell
`
mysql -u anabig114221 -pBigdata123 create_table.sql
`
#### To load the csv files into the created table schema, run load_csv.sql in shell
`
mysql -u anabig114221-pBigdata123 load_csv.sql
`
### SQOOP COMMANDS TO IMPORT TABLES INTO HIVE AND SAVE AS AVRO FILES

##### Run below commands in shell to import all tables as avro into HDFS
##### Below file also create a warehouse dir to store the data files and 
##### the same dir is used to create the tables in hive.
`sh sqoop_import_as_avro.sh`

#### Run below file in hive shell to drop existing tables and create new database using the avro data which was imported into HDFS via sqoop.  
`
hive -f hive_create_table.sql
`
