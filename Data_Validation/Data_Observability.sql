1. Data Staleness(Data Freshness)
Some datasets are expected to be up to date for some period, 
and you will usually document this in an SLA for downstream consumers.
we needed to notify consumers if there were any delays.

https://substack.wasteman.codes/p/sql-alerting-for-data-pipelines-a

    SELECT 
        DATEDIFF(HOUR, MAX(event_date_time_utc), CURRENT_TIMESTAMP()) < 12
    FROM SOURCE_TABLE
    
-- It returns a boolean on whether there is data in the table for events that occurred within the last 18 hours. 
-- If this query returns False, we will alert. Note that even though our SLA was 24 hours, 
-- we alerted our internal team well before then to give us time to push any fixes if need be.

2. Existence of duplicates

    SELECT 
        CASE 
            WHEN COUNT(*) - COUNT(DISTINCT event_id) = 0 THEN 'No Duplicates'
            ELSE 'Duplicates Exist'
        END AS duplication_check
    FROM events

    DO $$ 
    BEGIN
        IF (SELECT COUNT(*) - COUNT(DISTINCT event_id) FROM events) > 0 THEN
            RAISE EXCEPTION 'Duplicates Exist in events table!';
        END IF;
    END $$;

    

