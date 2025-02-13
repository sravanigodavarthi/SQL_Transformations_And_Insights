Output share of US users that are active. 
Active users are the ones with an "open" status in the table.

To find the share of US users that are active, we need to count 
the total number of users and the number of active users in 
the fb_active_users table for the USA. We can then divide the number of active users 
by the total number of users to get the share of active users.


fb_active_users
country: text
name: text
status: text
user_id: bigint


-- share active users in US -> total_number_of_active_users/total_number_users_usa

SELECT AVG(CASE WHEN status = 'open' THEN 1 ELSE 0 END) AS US_share
FROM fb_active_users
WHERE country = 'USA';


SELECT SUM(CASE WHEN status = 'open' THEN 1 ELSE 0 END) * 1.0 /COUNT(user_id) AS us_share
FROM fb_active_users
WHERE country = 'USA'

SELECT COUNT(CASE WHEN status = 'open' THEN 1 ELSE NULL END) * 1.0 /COUNT(user_id) AS us_share
FROM fb_active_users
WHERE country = 'USA'

- With COUNT, if we use ELSE 0 in the CASE expression,
it counts all the rows. COUNT only ignores NULL values.

- For fractions, it is best practice to multiply by 1.0 to 
avoid integer division, which truncates the decimal part.