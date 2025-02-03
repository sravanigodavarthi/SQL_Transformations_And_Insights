1. COUNT ROWS

    SELECT COUNT(*) 
    FROM source_table
    SELECT COUNT(*)
    FROM target_table
    
    -> verify if the number of rows in the source and target tables match

2. Check Duplicates

    SELECT column_name, COUNT(*)
    FROM table_name
    GROUP BY column_name
    HAVING COUNT(*) > 1

    -> Identify the duplicate records in a table

3. Compare Data between source and target table

    SELECT * 
    FROM source_table
    EXCEPT 
    SELECT *
    FROM target_table

    This returns the rows from first query but not in second query
    so, This query returns the rows that are in source_table but not in target_table

    -> Check for discrepancies between the source and target tables

4. Validate Data transformation

    SELECT 
        CASE 
            WHEN condition THEN 'valid'
        ELSE 'invalid'
        END AS validation_status
    FROM table_name

Performance and integrity checks

5. Check for NULL values

    SELECT *
    FROM table_name
    WHERE column_name IS NULL

6. Data type validation

    SELECT
    CASE 
        WHEN column_name LIKE '%[^0-9]%' THEN 'Invalid'
        ELSE 'valid'
    END AS validation_status
    FROM table_name

7. Primary key Uniqueness

    SELECT primary_key_column_name, COUNT(*)
    FROM table_name
    GROUP BY primary_key_column_name
    HAVING COUNT(*) > 1

