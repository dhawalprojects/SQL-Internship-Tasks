@echo off
mysql -u root -pYourMySQLPassword sakila < sakila_backup_mysql.sql
pause 