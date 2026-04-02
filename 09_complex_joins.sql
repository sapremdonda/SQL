-- ==============================================================================
-- FILE: 09_complex_joins.sql
-- DESCRIPTION: Advanced table relationships.
-- ==============================================================================

-- 1. SELF JOIN: Find customers who live in the same country
SELECT 
    A.FirstName AS Customer1, 
    B.FirstName AS Customer2, 
    A.Country
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID 
AND A.Country = B.Country
ORDER BY A.Country;

-- 2. CROSS JOIN: Create a matrix of every customer matched with every category
-- (Useful for generating theoretical recommendation tables)
SELECT 
    c.FirstName, 
    cat.CategoryName
FROM Customers c
CROSS JOIN Categories cat;

-- 3. FULL OUTER JOIN (Simulated using UNION)
-- Show ALL Customers and ALL Orders, matching where possible, leaving NULLs where not
SELECT c.FirstName, o.OrderID, o.Status
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
UNION
SELECT c.FirstName, o.OrderID, o.Status
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;
