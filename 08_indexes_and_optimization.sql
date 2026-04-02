-- ==============================================================================
-- FILE: 08_indexes_and_optimization.sql
-- DESCRIPTION: Improving query read speeds for large datasets using Indexes.
-- ==============================================================================

-- CREATE INDEX: Speed up queries that search by Country
-- (Without this, the DB has to scan every single row to find 'Canada')
CREATE INDEX idx_customer_country 
ON Customers (Country);

-- CREATE UNIQUE INDEX: Ensure no two products have the exact same name
CREATE UNIQUE INDEX idx_unique_product_name 
ON Products (ProductName);

-- Multi-Column Index: Optimize queries that filter by both Status and OrderDate
CREATE INDEX idx_order_status_date 
ON Orders (Status, OrderDate);

-- DROP INDEX: Removing an index if it's slowing down INSERT/UPDATE operations too much
-- Note: Syntax varies slightly by SQL dialect (MySQL shown here)
ALTER TABLE Customers DROP INDEX idx_customer_country;
