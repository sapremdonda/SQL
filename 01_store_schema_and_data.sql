-- ==============================================================================
-- FILE: 01_store_schema_and_data.sql
-- DESCRIPTION: Database initialization, table structures, and mock data.
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS TechStoreDB;
USE TechStoreDB;

-- CREATE TABLES WITH CONSTRAINTS
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(50) DEFAULT 'USA',
    RegistrationDate DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    -- CHECK constraint to ensure price and stock are never negative
    CONSTRAINT CHK_ProductValidity CHECK (Price > 0 AND StockQuantity >= 0),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ALTER TABLE Example
ALTER TABLE Customers ADD COLUMN PhoneNumber VARCHAR(20);

-- INSERT SAMPLE DATA
INSERT INTO Categories (CategoryName, Description) VALUES 
('Laptops', 'High performance computing'),
('Audio', 'Headphones and speakers'),
('Accessories', 'Cables, mice, and keyboards');

INSERT INTO Customers (FirstName, LastName, Email, Country) VALUES 
('Alice', 'Johnson', 'alice@example.com', 'USA'),
('Bob', 'Smith', 'bob@example.com', 'Canada'),
('Charlie', 'Brown', 'charlie@example.com', 'UK');

INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES 
('ProBook 15', 1, 1200.00, 50),
('Noise Cancelling Headphones', 2, 250.00, 100),
('Wireless Mouse', 3, 25.99, 200),
('Mechanical Keyboard', 3, 85.00, 75);

INSERT INTO Orders (CustomerID, Status) VALUES 
(1, 'Shipped'),
(1, 'Pending'),
(2, 'Delivered');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES 
(1, 1, 1, 1200.00),
(1, 3, 1, 25.99),
(2, 2, 2, 250.00),
(3, 4, 1, 85.00);
