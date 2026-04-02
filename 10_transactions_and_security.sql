-- ==============================================================================
-- FILE: 10_transactions_and_security.sql
-- DESCRIPTION: Ensuring data integrity during multi-step operations.
-- ==============================================================================

-- Scenario: A customer places an order. We must deduct stock AND create the order details.
-- If one fails, BOTH must fail so we don't have broken data.

START TRANSACTION;

-- Step 1: Create the new Order record
INSERT INTO Orders (CustomerID, Status) 
VALUES (2, 'Pending');

-- Grab the new Order ID dynamically
SET @NewOrderID = LAST_INSERT_ID();

-- Step 2: Add the item to OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) 
VALUES (@NewOrderID, 1, 2, 1200.00);

-- Step 3: Deduct the stock from the Products table
UPDATE Products 
SET StockQuantity = StockQuantity - 2 
WHERE ProductID = 1;

-- If everything above worked perfectly, we save the changes permanently:
COMMIT;

-- NOTE: If an error occurred (e.g., out of stock), we would run this instead to undo everything:
-- ROLLBACK;
