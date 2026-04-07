-- question 1
SELECT 
    user_id, 
    COUNT(id) AS total_orders, 
    SUM(total_amount) AS total_spent
FROM orders
WHERE status = 'completed'
GROUP BY user_id
HAVING COUNT(id) >= 3 AND SUM(total_amount) > 10000
ORDER BY total_spent DESC
LIMIT 5; q

/* I used the WHERE clause first to filter out cancelled orders before grouping, which improves performance. 
Then, I used the HAVING clause to filter the aggregated results (COUNT and SUM) to meet the business rules before finally sorting and limiting to the top 5. */