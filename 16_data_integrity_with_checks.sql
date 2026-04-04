-- ==============================================================================
-- FILE: 16_data_integrity_with_checks.sql
-- DESCRIPTION: Ensuring business logic is enforced at the database level.
-- ==============================================================================

-- 1. Adding a CHECK constraint to an existing table
-- Ensure that the Status of an order can only be specific values
ALTER TABLE Orders
ADD CONSTRAINT CHK_OrderStatus 
CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'));

-- 2. Adding a CHECK for pricing logic
-- Ensure that if a product is in the 'Accessories' category, it can't be over $1000
-- Note: Some SQL versions require this logic in a Trigger, but standard SQL uses CHECK.
ALTER TABLE Products
ADD CONSTRAINT CHK_AccessoryPrice 
CHECK (NOT (CategoryID = 3 AND Price > 1000));

-- 3. Testing the constraint (This would fail if uncommented)
-- INSERT INTO Orders (CustomerID, Status) VALUES (1, 'UnknownStatus');
