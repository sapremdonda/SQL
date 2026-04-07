-- question 2
SELECT 
    user_id, 
    MAX(login_time) AS login_time
FROM user_logins
GROUP BY user_id;

/* Since the output only requires user_id and login_time  (and not the specific login id), a simple GROUP BY with the MAX() aggregate function is the cleanest and fastest approach. 
(Note: If we needed the whole row, I would have used ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_time DESC)) */

-- question 3

WITH SubscriptionHistory AS (
    SELECT 
        user_id,
        start_date,
        LAG(end_date) OVER (PARTITION BY user_id ORDER BY start_date) AS previous_end_date
    FROM subscriptions
)
SELECT DISTINCT user_id
FROM SubscriptionHistory
WHERE DATEDIFF(start_date, previous_end_date) > 7;

/* I used a Common Table Expression (CTE) and the LAG() window function. LAG(end_date) allows me to pull the end date of a user's previous subscription into the current row. I then wrapped it in an outer query to calculate the difference between the current start date and the previous end date. 
(Note: DATEDIFF syntax can vary slightly by SQL dialect; in PostgreSQL, it would just be start_date - previous_end_date > 7). */

-- question 4

SELECT 
    user_id, 
    created_at, 
    amount,
    SUM(amount) OVER (PARTITION BY user_id ORDER BY created_at) AS running_total
FROM transactions
ORDER BY user_id, created_at;

/* The window function SUM(amount) OVER (...) is perfect here. 
By partitioning by user_id and ordering by created_at, the database automatically calculates the cumulative sum row-by-row for each individual user without needing complex self-joins. */