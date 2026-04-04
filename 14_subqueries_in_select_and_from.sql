-- ==============================================================================
-- FILE: 14_subqueries_in_select_and_from.sql
-- DESCRIPTION: Using nested queries to create dynamic columns and temporary data sets.
-- ==============================================================================

USE TechStoreDB;

-- 1. Subquery in SELECT: Show each product and how much it differs from the average price
SELECT 
    ProductName, 
    Price,
    (SELECT AVG(Price) FROM Products) AS AverageGlobalPrice,
    Price - (SELECT AVG(Price) FROM Products) AS PriceDifference
FROM Products;

-- 2. Subquery in FROM: Treat a query result as a temporary table (Derived Table)
-- Finding the max order value for each customer
SELECT 
    MaxOrderTable.CustomerID, 
    MaxOrderTable.HighestTicketItem
FROM (
    SELECT CustomerID, MAX(UnitPrice * Quantity) AS HighestTicketItem
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY CustomerID
) AS MaxOrderTable
WHERE MaxOrderTable.HighestTicketItem > 500;
