-- ==============================================================================
-- FILE: 19_automation_events_and_metadata.sql
-- DESCRIPTION: Database scheduled tasks and system metadata inspection.
-- ==============================================================================

USE TechStoreDB;

-- 1. CREATE EVENT: Scheduled Automation
-- Automatically clean up "Cancelled" orders that are older than 1 year, running every night.
DELIMITER //

CREATE EVENT IF NOT EXISTS evnt_CleanupOldCancelledOrders
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM Orders 
    WHERE Status = 'Cancelled' 
    AND OrderDate < DATE_SUB(NOW(), INTERVAL 1 YEAR);
END //

DELIMITER ;


-- 2. INFORMATION SCHEMA: The Database Dictionary
-- Querying the system to get a list of all tables and how many rows they have.
SELECT 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'TechStoreDB';

-- 3. Find every column in the entire database that is of type 'DATETIME'
SELECT 
    TABLE_NAME, 
    COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'TechStoreDB' 
AND DATA_TYPE = 'datetime';
