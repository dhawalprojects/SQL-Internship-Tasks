@echo off
psql -U postgres -d sakila -f sakila_backup_pg.sql
pause 