Activity Table:

machine_id process_id activity_type timestamp
0 0 start 0.712
0 0 end 1.520
0 1 start 3.140
0 1 end 4.120
1 0 start 0.550
1 0 end 1.550
1 1 start 0.430
1 1 end 1.420

output:
machine_id processing_time
0 0.894
1 0.995

WITH processing_time AS(
SELECT A1.machine_id AS machine_id, A1.process_id AS process_id, A1.timestamp - A2.timestamp AS processing_time
FROM Activity A1
JOIN Activity A2 ON A1.machine_id = A2.machine_id
                AND A1.process_id = A2.process_id
                AND A1.activity_type = 'end'
                AND A2.activity_type = 'start'
)
SELECT machine_id, AVG(processing_time) AS avg_processing_time
FROM processing_time
GROUP BY machine_id


WITH processing_time AS (
    SELECT 
        machine_id,
        process_id,
        SUM(CASE WHEN activity_type = 'start' THEN -timestamp ELSE timestamp END) AS processing_time
    FROM Activity
    GROUP BY machine_id, process_id
)
SELECT machine_id, AVG(processing_time) AS avg_processing_time
FROM processing_time
GROUP BY machine_id;