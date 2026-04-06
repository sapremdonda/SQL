-- ==============================================================================
-- FILE: 18_full_text_search.sql
-- DESCRIPTION: Creating a high-performance search engine for product descriptions.
-- ==============================================================================

USE TechStoreDB;

-- 1. Add a FULLTEXT index to the ProductName and Description (if applicable)
-- Standard LIKE '%word%' is too slow for big text blocks. FULLTEXT is lightning fast.
ALTER TABLE Products 
ADD FULLTEXT idx_fulltext_product (ProductName);

-- 2. Use MATCH() AGAINST() to perform a natural language search
-- This searches for anything related to "Wireless" or "Keyboard"
SELECT 
    ProductID, 
    ProductName, 
    Price
FROM Products
WHERE MATCH(ProductName) AGAINST('Wireless Keyboard' IN NATURAL LANGUAGE MODE);

-- 3. Boolean Mode Search
-- Find a product that MUST have "Monitor" but MUST NOT have "Gaming"
SELECT ProductName 
FROM Products
WHERE MATCH(ProductName) AGAINST('+Monitor -Gaming' IN BOOLEAN MODE);
