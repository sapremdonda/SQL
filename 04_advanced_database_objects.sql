-- ==============================================================================
-- FILE: 04_advanced_database_objects.sql
-- DESCRIPTION: Views, Procedures, and Triggers for backend automation.
-- ==============================================================================

-- 1. VIEW
-- Create a secure view that hides customer emails but shows their order history
CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    COUNT(o.OrderID) AS TotalOrders,
    MAX(o.OrderDate) AS LastOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, FullName;

-- To test the view: SELECT * FROM vw_CustomerOrderSummary;


-- 2. STORED PROCEDURE
-- A procedure to quickly add a new product category and a product inside it simultaneously
DELIMITER //

CREATE PROCEDURE sp_AddProductWithCategory(
    IN p_CategoryName VARCHAR(50),
    IN p_ProductName VARCHAR(100),
    IN p_Price DECIMAL(10, 2),
    IN p_Stock INT
)
BEGIN
    DECLARE new_category_id INT;
    
    -- Insert new category
    INSERT INTO Categories (CategoryName) VALUES (p_CategoryName);
    
    -- Get the auto-generated ID of the category we just created
    SET new_category_id = LAST_INSERT_ID();
    
    -- Insert the product using that new category ID
    INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) 
    VALUES (p_ProductName, new_category_id, p_Price, p_Stock);
END //

DELIMITER ;

-- To test: CALL sp_AddProductWithCategory('Monitors', '4K Gaming Monitor', 450.00, 30);


-- 3. TRIGGER
-- Automatically reduce product stock when a new OrderDetail is inserted
DELIMITER //

CREATE TRIGGER trg_ReduceStockAfterOrder
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products 
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END //

DELIMITER ;
