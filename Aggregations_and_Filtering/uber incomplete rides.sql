Write a query to fetch Rides with incomplete transactions on a Uber platforms

transaction table and payment table

Conditions that states incomplete transactions
The ride id exists in the transaction table but not in the payment table.

Exclude ongoing rides (meaning it's still in progress),
end_timestamp can be either NULL (never ended) or a future timestamp.


SELECT ride_id AS incomplete_rides
FROM transaction t 
LEFT JOIN payment p ON t.ride_id = p.ride_id 
WHERE p.ride_id IS NULL
    AND (t.end_timestamp IS NOT NULL OR t.end_timestamp <= CURRENT_TIMESTAMP)


SELECT ride_id AS incomplete_rides
FROM transaction t
WHERE ride_id NOT EXIST(SELECT 1 FROM payment p WHERE t.ride_id = p.ride_id)
        AND (t.end_timestamp IS NOT NULL OR t.end_timestamp <= CURRENT_TIMESTAMP)