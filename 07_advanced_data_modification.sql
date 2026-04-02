-- ==============================================================================
-- FILE: 07_advanced_data_modification.sql
-- DESCRIPTION: Bulk data manipulation and archiving records.
-- ==============================================================================

-- 1. CREATE AN ARCHIVE TABLE
CREATE TABLE ArchivedOrders (
    ArchiveID INT AUTO_INCREMENT PRIMARY KEY,
    OriginalOrderID INT,
    CustomerID INT,
    OrderDate DATETIME,
    ArchivedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. INSERT INTO SELECT: Move delivered orders into the Archive table
INSERT INTO ArchivedOrders (OriginalOrderID, CustomerID, OrderDate)
SELECT OrderID, CustomerID, OrderDate 
FROM Orders 
WHERE Status = 'Delivered';

-- 3. ADVANCED UPDATE: Increase all 'Accessories' category prices by 10%
-- (Assuming CategoryID 3 is Accessories)
UPDATE Products
SET Price = ROUND(Price * 1.10, 2)
WHERE CategoryID = 3;

-- 4. CONDITIONAL DELETE: Remove customers who have no orders and registered over a year ago
DELETE FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders)
AND DATEDIFF(CURDATE(), RegistrationDate) > 365;
