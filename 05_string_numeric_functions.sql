-- ==============================================================================
-- FILE: 05_string_numeric_functions.sql
-- DESCRIPTION: Formatting data using built-in String and Numeric functions.
-- ==============================================================================

USE TechStoreDB;

-- 1. STRING FUNCTIONS
-- Format customer names into a single column, uppercase the last name
SELECT 
    CustomerID,
    CONCAT(FirstName, ' ', UPPER(LastName)) AS FormattedName,
    LENGTH(Email) AS EmailLength,
    LOWER(Country) AS CountryCode
FROM Customers;

-- Extract just the domain from the customer's email using SUBSTRING and LOCATE
SELECT 
    Email,
    SUBSTRING(Email, LOCATE('@', Email) + 1) AS EmailDomain
FROM Customers;

-- Replace 'USA' with 'United States' for reporting purposes
SELECT 
    FirstName,
    REPLACE(Country, 'USA', 'United States') AS FullCountryName
FROM Customers;

-- 2. NUMERIC FUNCTIONS
-- Apply a 15% discount and show different rounding methods
SELECT 
    ProductName,
    Price AS OriginalPrice,
    Price * 0.85 AS DiscountedPrice,
    ROUND(Price * 0.85, 2) AS RoundedToCents,
    CEILING(Price * 0.85) AS RoundedUpToDollar,
    FLOOR(Price * 0.85) AS RoundedDownToDollar
FROM Products;

-- Use MOD (Modulo) to find odd-numbered Product IDs for a random audit
SELECT ProductID, ProductName 
FROM Products 
WHERE MOD(ProductID, 2) != 0;
