-- ==============================================================================
-- FILE: 13_database_security_and_admin.sql
-- DESCRIPTION: Managing user permissions and security roles.
-- ==============================================================================

-- 1. Create a new database user for a Junior Data Analyst
CREATE USER 'junior_analyst'@'localhost' IDENTIFIED BY 'SecurePass123!';

-- 2. GRANT PERMISSIONS: Give them READ-ONLY access to the database
-- They can use SELECT, but cannot INSERT, UPDATE, or DELETE
GRANT SELECT ON TechStoreDB.* TO 'junior_analyst'@'localhost';

-- 3. Create a user for the Application Backend
CREATE USER 'app_backend'@'localhost' IDENTIFIED BY 'AppPassword999!';

-- Give the backend full CRUD permissions, but NOT permission to drop tables
GRANT SELECT, INSERT, UPDATE, DELETE ON TechStoreDB.* TO 'app_backend'@'localhost';

-- 4. REVOKE PERMISSIONS: The backend got hacked! Revoke DELETE privileges quickly.
REVOKE DELETE ON TechStoreDB.* FROM 'app_backend'@'localhost';

-- Apply the permission changes to the server
FLUSH PRIVILEGES;
