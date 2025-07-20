@echo off
mysqldump -u root -pYourMySQLPassword sakila > sakila_backup_mysql.sql
pause 