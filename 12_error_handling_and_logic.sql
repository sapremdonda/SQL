-- ==============================================================================
-- FILE: 12_error_handling_and_logic.sql
-- DESCRIPTION: Safe transactions that automatically roll back on errors.
-- ==============================================================================

DELIMITER //

CREATE PROCEDURE sp_SafeOrderCreation(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Quantity INT
)
BEGIN
    -- Declare an exit handler: If ANY SQL error happens, rollback and exit
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Error: Transaction Failed and Rolled Back' AS StatusMessage;
    END;

    START TRANSACTION;

    -- Step 1: Create Order
    INSERT INTO Orders (CustomerID, Status) VALUES (p_CustomerID, 'Pending');
    SET @OrderID = LAST_INSERT_ID();

    -- Step 2: Grab the current price of the product
    SET @Price = (SELECT Price FROM Products WHERE ProductID = p_ProductID);

    -- Step 3: Insert Order Details
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) 
    VALUES (@OrderID, p_ProductID, p_Quantity, @Price);

    -- Step 4: Deduct Stock
    UPDATE Products 
    SET StockQuantity = StockQuantity - p_Quantity 
    WHERE ProductID = p_ProductID;

    -- If we made it here without errors, save it!
    COMMIT;
    SELECT 'Success: Order Created' AS StatusMessage;
    
END //

DELIMITER ;
