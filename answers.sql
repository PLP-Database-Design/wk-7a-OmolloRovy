-- 1NF (First Normal Form)

SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) AS numbers
ON
    LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY
    OrderID;

-- 2NF (Second Normal Form)
use customer;
-- Create a new table for Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(255) NOT NULL
);

-- Insert values into the Customers table
INSERT INTO Customers (CustomerName) VALUES
('John Doe'),
('Jane Smith'),
('Emily Clark');

-- Create a new table for Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert values into the Orders table
INSERT INTO Orders (OrderID, CustomerID) VALUES
(101, (SELECT CustomerID FROM Customers WHERE CustomerName = 'John Doe')),
(102, (SELECT CustomerID FROM Customers WHERE CustomerName = 'Jane Smith')),
(103, (SELECT CustomerID FROM Customers WHERE CustomerName = 'Emily Clark'));

-- Create a new table for OrderDetails in 2NF
CREATE TABLE OrderDetails2NF (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Product VARCHAR(255) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert values into the OrderDetails2NF table
INSERT INTO OrderDetails2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Display the new tables and their contents
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails2NF;
