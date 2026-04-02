-- ==============================================================================
-- FILE: 03_aggregations_and_subqueries.sql
-- DESCRIPTION: Math operations, grouping, and complex nested queries.
-- ==============================================================================

-- SUM, GROUP BY, & MATH
-- Calculate the total revenue for every order
SELECT 
    OrderID, 
    SUM(Quantity * UnitPrice) AS TotalOrderValue
FROM OrderDetails
GROUP BY OrderID;

-- COUNT, AVG, & HAVING
-- Find categories that have more than 1 product, and show the average price
SELECT 
    c.CategoryName, 
    COUNT(p.ProductID) AS ProductCount, 
    AVG(p.Price) AS AveragePrice
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
HAVING COUNT(p.ProductID) > 1;

-- IFNULL / COALESCE
-- Show customer phone numbers, replacing NULLs with 'No Phone Provided'
SELECT 
    FirstName, 
    LastName, 
    IFNULL(PhoneNumber, 'No Phone Provided') AS ContactNumber
FROM Customers;

-- CASE STATEMENT
-- Label products as Budget, Standard, or Premium based on price
SELECT 
    ProductName, 
    Price,
    CASE
        WHEN Price < 50 THEN 'Budget'
        WHEN Price BETWEEN 50 AND 500 THEN 'Standard'
        ELSE 'Premium'
    END AS PriceCategory
FROM Products;

-- EXISTS (Subquery)
-- Find all customers who have placed at least one order
SELECT FirstName, LastName 
FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID
);

-- ANY (Subquery)
-- Find products that cost more than ANY product in Category 3 (Accessories)
SELECT ProductName, Price 
FROM Products
WHERE Price > ANY (
    SELECT Price FROM Products WHERE CategoryID = 3
);
