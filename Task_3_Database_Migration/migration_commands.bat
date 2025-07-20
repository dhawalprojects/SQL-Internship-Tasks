@echo off
REM Export Sakila from MySQL
mysqldump -u root -pYourMySQLPassword sakila > sakila_mysql.sql

REM Migrate to PostgreSQL using pgloader (edit connection strings as needed)
pgloader mysql://root:YourMySQLPassword@localhost/sakila postgresql://postgres:YourPGPassword@localhost/sakila

REM Import SQL file to PostgreSQL (if using SQL dump)
psql -U postgres -d sakila -f sakila_postgres.sql

pause 