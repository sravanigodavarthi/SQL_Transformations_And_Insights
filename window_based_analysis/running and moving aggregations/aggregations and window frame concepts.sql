Running window frame - Aggregates over all rows from the beginning to the current row.
The window grows as you progress through the data. 
It starts with just the first row and keeps adding subsequent rows.

Example: Tracking total sales revenue for the year.

Moving window frame - Aggregates over a fixed-size window.
The window moves as you progress through the data, always maintaining the same fixed size.

Examples:
Analyze weekly sales trends.
Track 7-day moving averages to identify recent performance spikes or dips.


tweets Table:
Column Name	Type
user_id	integer
tweet_date	timestamp
tweet_count	integer


example Input:
user_id	tweet_date	tweet_count
111	06/01/2022 00:00:00	2
111	06/02/2022 00:00:00	1
111	06/03/2022 00:00:00	3
111	06/04/2022 00:00:00	4
111	06/05/2022 00:00:00	5


SELECT user_id,
      tweet_date,
      SUM(tweet_count) OVER() AS overall_total, -- Total across all rows in the table
      SUM(tweet_count) OVER(PARTITION BY user_id) AS total_per_user, -- Total per user (Total per group)
      SUM(tweet_count) OVER(
                            PARTITION BY user_id 
                            ORDER BY tweet_date
                        ) AS running_total_per_user, -- Running total per user (default is ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
      SUM(tweet_count) OVER (
                            PARTITION BY user_id
                            ORDER BY tweet_date
                            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
                        ) AS moving_total_per_user -- Moving total per user (fixed 3-row window)

FROM tweets;

example output for different combinations:
user_id	tweet_date	asoverall_total	total_per_user	running_total_per_user	moving_total_per_user
111	06/01/2022 00:00:00	71	25	2	2
111	06/02/2022 00:00:00	71	25	3	3
111	06/03/2022 00:00:00	71	25	6	6
111	06/04/2022 00:00:00	71	25	10	8
111	06/05/2022 00:00:00	71	25	15	12
111	06/06/2022 00:00:00	71	25	19	13
111	06/07/2022 00:00:00	71	25	25	15
199	06/01/2022 00:00:00	71	34	7	7
199	06/02/2022 00:00:00	71	34	12	12
199	06/03/2022 00:00:00	71	34	21	21
199	06/04/2022 00:00:00	71	34	22	15
199	06/05/2022 00:00:00	71	34	30	18
199	06/06/2022 00:00:00	71	34	32	11
199	06/07/2022 00:00:00	71	34	34	12


1. Default Window Frame (Cumulative Running Total):
Question:
For each user, calculate the cumulative total of tweets up to each date. 
The cumulative total should include all tweets from the first date to the current date.

Explanation:
This uses the default frame: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.

2. Fixed Window Frame (Moving Total):
Question:
For each user, calculate the total number of tweets for the last 3 days, including the current day. If there are fewer than 3 days of data, include all available days.

Explanation:
This uses a fixed window: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW.

3. Range-Based Frame:
Question:
For each user, calculate the total number of tweets for the current date and all dates before it, where the date difference is no more than 3 days.

Explanation:
This uses a range-based window: RANGE BETWEEN INTERVAL 3 DAY PRECEDING AND CURRENT ROW.


Sure! If you are planning to add various window frame examples, here are some SQL question ideas to showcase different frame definitions. Each question explores a unique aspect of how window frames influence aggregation:

1. Default Window Frame (Cumulative Running Total):
Question:
For each user, calculate the cumulative total of tweets up to each date. The cumulative total should include all tweets from the first date to the current date.

Explanation:
This uses the default frame: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.

2. Fixed Window Frame (Moving Total):
Question:
For each user, calculate the total number of tweets for the last 3 days, including the current day. If there are fewer than 3 days of data, include all available days.

Explanation:
This uses a fixed window: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW.

4. Sliding Window with Fixed Offset:
Question:
For each user, calculate the total tweets for a 7-day window ending 1 day before the current date.

Explanation:
This uses a custom frame: ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING.

6. Unbounded Following (Future Rows):
Question:
For each user, calculate the total tweets for all dates from the current date onward.

Explanation:
This uses a frame that includes all future rows: ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING.

7. Centered Frame:
Question:
For each user, calculate the total tweets for a symmetric 3-day window centered on the current date (1 day before, current day, and 1 day after).

Explanation:
This uses a centered window: ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING.

8. Partition Total (Ignoring Date):
Question:
For each user, calculate the total number of tweets across all dates.

Explanation:
This ignores the ordering and uses the entire partition: ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING.
