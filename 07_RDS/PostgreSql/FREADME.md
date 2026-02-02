----------------------------------------------------
<!-- what is postgresql  -->

















<!-- Some basics command of this relational database -->

------->  PostgreSQL Daily Use Commands <---------------------
CONNECTION:
           psql -U username -d dbname - Connect to database
           \c dbname - Switch database
           \q - Quit

BASIC INFO:
           \l - List databases
           \dt - List tables
           \d tablename - Show table structure
            SELECT version(); - Check version

DATA QUERIES:
             SELECT * FROM table; - View all data
             SELECT * FROM table WHERE id=1; - View specific row
             SELECT * FROM table ORDER BY date DESC; - Sort data
             SELECT * FROM table LIMIT 10; - First 10 rows
             SELECT COUNT(*) FROM table; - Count rows
            SELECT * FROM table WHERE name LIKE 'A%'; - Search pattern

MODIFY DATA:
            INSERT INTO table (col1, col2) VALUES ('val1', 'val2'); - Add data
            UPDATE table SET column='value' WHERE id=1; - Update data
            DELETE FROM table WHERE id=5; - Delete data

TABLE CHANGES:
              ALTER TABLE table ADD COLUMN newcol VARCHAR(100); - Add column
              ALTER TABLE table DROP COLUMN columnname; - Remove column
              ALTER TABLE table RENAME COLUMN oldname TO newname; - Rename column

BACKUP:
       pg_dump dbname > backup.sql - Backup database
       psql dbname < backup.sql - Restore database

USER MANAGEMENT:
                 CREATE USER username WITH PASSWORD 'pass'; - Create user
                 GRANT SELECT ON table TO username; - Give permission
                 \du - List users

TROUBLESHOOTING:
                  If \l fails: SELECT datname FROM pg_database;
                  Check connections: SELECT * FROM pg_stat_activity;
                  Kill connection: SELECT pg_terminate_backend(pid);

PERFORMANCE:
            CREATE INDEX idx_name ON table(column); - Create index
            EXPLAIN SELECT * FROM table; - Check query plan
            VACUUM table; - Clean up table

EXPORT/IMPORT:
              \copy table TO 'file.csv' CSV HEADER; - Export to CSV
              \copy table FROM 'file.csv' CSV HEADER; - Import from CSV

TRANSACTIONS:
             BEGIN; - Start transaction
             COMMIT; - Save changes
             ROLLBACK; - Cancel changes

