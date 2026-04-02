-- ==============================================================================
-- FILE: 02_queries_and_joins.sql
-- DESCRIPTION: Data retrieval, filtering, and table joins.
-- ==============================================================================

-- BASIC SELECT, WHERE, ORDER BY, LIMIT
-- Find the top 2 most expensive products in stock
SELECT ProductName, Price, StockQuantity 
FROM Products 
WHERE StockQuantity > 0 
ORDER BY Price DESC 
LIMIT 2;

-- LIKE & WILDCARDS
-- Find all customers whose email uses an 'example.com' domain
SELECT FirstName, LastName, Email 
FROM Customers 
WHERE Email LIKE '%@example.com';

-- IN & BETWEEN
-- Find products priced between $50 and $500 in specific categories
SELECT ProductName, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 500 
AND CategoryID IN (2, 3);

-- INNER JOIN with ALIASES
-- See exactly what Alice ordered in Order #1
SELECT 
    o.OrderID, 
    c.FirstName, 
    p.ProductName, 
    od.Quantity, 
    od.UnitPrice
FROM OrderDetails od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE c.FirstName = 'Alice';

-- LEFT JOIN
-- Find ALL customers, and show their orders if they have any (shows NULL for customers with no orders)
SELECT c.FirstName, c.LastName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- UNION
-- Combine a list of Customer Emails and Supplier Emails (simulated here with a static string) into one mailing list
SELECT Email, 'Customer' AS Role FROM Customers
UNION
SELECT 'admin@techstore.com', 'Employee' AS Role;
