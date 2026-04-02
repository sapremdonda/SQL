-- ==============================================================================
-- FILE: 06_date_time_functions.sql
-- DESCRIPTION: Calculating delivery windows and analyzing chronological data.
-- ==============================================================================

-- Current Date & Time vs Order Date
SELECT 
    OrderID,
    OrderDate,
    NOW() AS CurrentSystemTime,
    CURDATE() AS CurrentSystemDate
FROM Orders;

-- DATEDIFF: Calculate how many days ago an order was placed
SELECT 
    OrderID,
    OrderDate,
    DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
FROM Orders;

-- DATE_ADD: Calculate an estimated delivery date (Order Date + 5 days)
SELECT 
    OrderID,
    OrderDate,
    DATE_ADD(OrderDate, INTERVAL 5 DAY) AS EstimatedDelivery
FROM Orders;

-- EXTRACT: Break down order dates for Monthly/Yearly sales reports
SELECT 
    OrderID,
    EXTRACT(YEAR FROM OrderDate) AS OrderYear,
    EXTRACT(MONTH FROM OrderDate) AS OrderMonth,
    EXTRACT(DAY FROM OrderDate) AS OrderDay
FROM Orders
ORDER BY OrderYear DESC, OrderMonth DESC;
