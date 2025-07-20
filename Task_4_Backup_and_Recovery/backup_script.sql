-- MySQL manual backup (run in MySQL shell)
-- BACKUP DATABASE sakila TO DISK = 'sakila_backup_mysql.sql';

-- PostgreSQL manual backup (run in psql)
-- \! pg_dump -U postgres -d sakila -F p -f sakila_backup_pg.sql
