@echo off
pg_dump -U postgres -d sakila -F p -f sakila_backup_pg.sql
pause 