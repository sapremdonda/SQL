-- ==============================================================================
-- FILE: 15_exists_vs_in_operators.sql
-- DESCRIPTION: Comparing different methods to filter data based on related tables.
-- ==============================================================================

-- 1. Using IN: Find categories that actually have products assigned to them
SELECT CategoryName 
FROM Categories 
WHERE CategoryID IN (SELECT DISTINCT CategoryID FROM Products);

-- 2. Using EXISTS: Often faster for large datasets as it stops at the first match
-- Find customers who have placed an order in the last 30 days
SELECT FirstName, LastName 
FROM Customers c
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID 
    AND o.OrderDate > DATE_SUB(NOW(), INTERVAL 30 DAY)
);

-- 3. Using NOT EXISTS: Find "Ghost Products" (Products that have never been ordered)
SELECT ProductName 
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM OrderDetails od 
    WHERE od.ProductID = p.ProductID
);
