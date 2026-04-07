-- question 5

SELECT 
    o.user_id,
    SUM(oi.quantity * p.price) AS total_revenue,
    COUNT(DISTINCT DATE(o.created_at)) AS active_days
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.created_at >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY o.user_id
HAVING COUNT(DISTINCT DATE(o.created_at)) >= 5
ORDER BY total_revenue DESC
LIMIT 3;

/* I joined the necessary tables and immediately filtered for the last 30 days in the WHERE clause to drastically reduce the dataset size before grouping. 
I used COUNT(DISTINCT DATE(created_at)) to ensure multiple orders on the same day only count as one "active day." 
The HAVING clause enforces the 5-day rule before sorting for the top 3. */
