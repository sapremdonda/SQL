-- ==============================================================================
-- FILE: 17_json_data_handling.sql
-- DESCRIPTION: Managing unstructured NoSQL-style data within a SQL database.
-- ==============================================================================

USE TechStoreDB;

-- 1. Add a JSON column to store flexible product specifications (e.g., RAM, Color, OS)
ALTER TABLE Products 
ADD COLUMN Specifications JSON;

-- 2. Update a product with JSON data
UPDATE Products 
SET Specifications = '{
    "Color": "Space Gray", 
    "RAM": "16GB", 
    "Storage": "512GB SSD", 
    "Warranty": "2 Years"
}'
WHERE ProductID = 1;

-- 3. Querying INSIDE the JSON data
-- Find the RAM of the laptop without returning the whole JSON object
SELECT 
    ProductName, 
    JSON_EXTRACT(Specifications, '$.RAM') AS MemorySize
FROM Products
WHERE ProductID = 1;

-- 4. Filtering rows based on JSON values
-- Find all products that are 'Space Gray'
SELECT ProductName 
FROM Products 
WHERE JSON_EXTRACT(Specifications, '$.Color') = '"Space Gray"';
