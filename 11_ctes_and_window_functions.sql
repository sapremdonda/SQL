-- ==============================================================================
-- FILE: 11_ctes_and_window_functions.sql
-- DESCRIPTION: Advanced analytical queries using CTEs and Window Functions.
-- ==============================================================================

USE TechStoreDB;

-- 1. CTE (Common Table Expression)
-- Think of this as a temporary, readable subquery. 
-- Let's find customers whose total spending is above average.
WITH CustomerTotals AS (
    SELECT o.CustomerID, SUM(od.Quantity * od.UnitPrice) AS TotalSpent
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
)
SELECT c.FirstName, c.LastName, ct.TotalSpent
FROM Customers c
JOIN CustomerTotals ct ON c.CustomerID = ct.CustomerID
WHERE ct.TotalSpent > (SELECT AVG(TotalSpent) FROM CustomerTotals);


-- 2. WINDOW FUNCTIONS: ROW_NUMBER() and RANK()
-- Rank products within their specific categories by price (highest to lowest)
SELECT 
    CategoryID,
    ProductName,
    Price,
    RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS PriceRank,
    ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS RowNum
FROM Products;


-- 3. WINDOW FUNCTIONS: Running Total
-- Calculate the cumulative revenue of all orders over time
SELECT 
    o.OrderID,
    o.OrderDate,
    SUM(od.Quantity * od.UnitPrice) AS OrderRevenue,
    SUM(SUM(od.Quantity * od.UnitPrice)) OVER (ORDER BY o.OrderDate) AS RunningTotalRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.OrderDate;
