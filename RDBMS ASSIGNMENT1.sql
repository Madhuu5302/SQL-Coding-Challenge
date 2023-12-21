CREATE DATABASE ASSIGNMENT1;
USE ASSIGNMENT1;
--CUSTOMER TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) not null ,
    LastName VARCHAR(50) ,
    Email VARCHAR(100) ,
    Phone CHAR(10) unique,
    Address VARCHAR(255)
);
-- INSERTING VALUES INTO CUSTOMERS
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(100,'PRIYA','DARSHINI','priya@gmail.com','7684329125','ABC Street,Mumbai')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(101,'JANE','RICHARD','jane@gmail.com','7684398726','7/6 AB Street, Haryana')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(102,'SAM','PAUL','sam@gmail.com','7914329120','ACZ Colony, Vizag')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(103,'RAMESH','K','ramesh@gmail.com','9543269125','6 XYT Street, Bangalore')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(104,'SOWMYA','N','sowmiya@gmail.com','7684329346','3/2 MNM Colony, Dindigul')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(105,'JESSIE','R','jessie@gmail.com','9321429120','4 AXX Street, Tuticorin')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(106,'KARTIK','M','kartik@gmail.com','8873329125','3/9 XYZ Colony, Kanyakumari')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(107,'RAMYA','S','ramya@gmail.com','9098329125','1 ABC Street, Trichy')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(108,'SHIVA','RAM','shiva@gmail.com','7684365432','2/5 CE Colony, Chennai')
INSERT INTO [dbo].[Customers]([CustomerID],[FirstName],[LastName],[Email],[Phone],[Address])
VALUES(109,'KEERTHI','H','keerthi@gmail.com','7684923541','86/7  AB Colony, Madurai')
--PRODUCTS TABLE
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) ,
	Description VARCHAR(255),
    Price DECIMAL(10, 2) ,
);
-- INSERT RECORDS INTO PRODUCTS
INSERT INTO Products
VALUES(1000,"Realme Narzo 60X 5G","Stellar Green,6GB,128GB Storage |Up to 2TB External Memory | 50 MP AI Primary Camera | Segments only 33W Supervooc Charge",15000.00),
(1001,"Redmi Note 12 Pro 5G ","Glacier Blue, 6GB RAM, 128GB Storage",19543.00),
(1002,"Apple iPhone 14","128 GB - Midnight",61999.58),
(1003,"Redmi Note 8 Pro","Gamma Green, 6GB RAM, 128GB Storage with Helio G90T Processor",9799.98),
(1004,"Samsung Galaxy Tab S7","FE 31.5 cm Large Display, RAM 4 GB, ROM 64 GB Expandable, Wi-Fi Tablet, Mystic Black",39857.88),
(1005,"HP 250 G9 Business Laptop PC","12th Generation Intel® Core™ i3 processor|(15.6) 39.62 cm diagonal, HD anti-glare display with Intel® Iris® Xᵉ Graphics",43199.00),
(1006,"Apple Watch SE (2nd Gen)","Smart Watch w/Starlight Aluminium Case, Crash Detection, Heart Rate Monitor, Retina Display, Water Resistant",29500.00),
(1007,"Oppo A77","Sunset Orange, 4GB RAM, 128 Storage",12149.67),
(1008,"VIVO V27 5G","Magic Blue, 128 GB, 8GB RAM",29699.00),
(1009,"Fastrack Grey Dial Analog Watch","44 Millimetres, Brown, Leather, Quartz",4395.78);

SELECT * FROM PRODUCTS;

--ORDERS TABLE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
	TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
	);

--INSERTING RECORDS INTO ORDERS
INSERT INTO Orders
VALUES(1000,100,'2020-08-19',16879.25),
(1001,101,'2019-06-29',42000.00),
(1002,102,'2023-11-30',65020.00),
(1003,103,'2020-06-12',44000.00),
(1004,104,'2022-05-19',41987.78),
(1005,105,'2021-02-28',45000.00),
(1006,106,'2022-01-31',94097.00),
(1007,107,'2023-04-22',14000.00),
(1008,108,'2019-08-15',31322.99),
(1009,109,'2021-08-09',10000.00);
SELECT * FROM Orders;

--ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT ,
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- INSERT RECORDS INTO OrderDetails
INSERT INTO OrderDetails
VALUES(001,1000,1000,1),
(002,1001,1001,2),
(003,1002,1002,1),
(004,1003,1003,4),
(005,1004,1004,1),
(006,1005,1005,1),
(007,1006,1006,3),
(008,1007,1007,1),
(009,1008,1008,1),
(010,1009,1009,2);
SELECT * FROM OrderDetails;

--INVENTORY TABLE
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT ,
	QuantityInStock INT,
	LastStockUpdate INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- INSERT RECORDS INTO Inventory
INSERT INTO Inventory
VALUES(1,1000,3,16),
(2,1001,2,21),
(3,1002,4,40),
(4,1003,5,20),
(5,1004,5,15),
(6,1005,1,10),
(7,1006,4,12),
(8,1007,2,35),
(9,1008,2,25),
(10,1009,6,30);
SELECT * FROM Inventory;

--Q1
SELECT FirstName, LastName, Email FROM Customers;
--Q2
SELECT O.OrderID,O.OrderDate,C.FirstName FROM Customers C, Orders O;
--Q3
INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Address)
VALUES(110,'Gayathri','S','gayu78@gmail.com','87 ABC Street, Kerala');
SELECT * FROM Customers;
--Q4
UPDATE Products SET Price=Price+(Price*0.1);
SELECT * FROM Products;
--Q5
DELETE FROM OrderDetails WHERE OrderID =1001 ;
DELETE FROM Orders WHERE OrderID = 1001;
--Q6
INSERT INTO Orders
VALUES(1010,110,'2021-06-09',20980.00);
SELECT * FROM Orders;
--Q7
UPDATE Customers SET Email='ccc666@gmail.com',Address='61 ABC Colony, Maharashtra',Phone=9876763421 WHERE CustomerID=108;
SELECT * FROM Customers;
--Q8
UPDATE Orders 
SET TotalAmount=(SELECT SUM(O.Quantity*P.Price) FROM OrderDetails O JOIN Products P ON O.ProductID=P.ProductID WHERE O.OrderID=Orders.OrderID);
SELECT * FROM Orders;
--Q9
DELETE FROM Orders(DELETE FROM OrderDetails WHERE CustomerID=108); 
--Q10
INSERT INTO Products
VALUES(1012,'Redmi 9A','64GB RAM,32 pixels, BLACK Color',8989.00);
SELECT * FROM Products;
--Q11
DECLARE @NewDate DATE;
DECLARE @ID INT;
SET @NewDate = '2023-02-01';
SET @ID = 8;

UPDATE Orders
SET OrderDate = @NewDate
where OrderID = @ID
--Q12
ALTER TABLE Customers
ADD [orders placed] INT;
UPDATE Customers
SET [orders placed] = 0
where [orders placed] is NULL
UPDATE Customers
SET [orders placed] = (
    SELECT COUNT(*)
    FROM Orders
    where Customers.CustomerID = Orders.CustomerID
)
where [orders placed] =0;


--TASK4 Q1
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
--Q2
SELECT
	Products.ProductID,
	Products.ProductName,
	SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM
	OrderDetails
JOIN
	Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY
	Products.ProductID, Products.ProductName;
--Q3
SELECT
	Customers.CustomerID,
	Customers.FirstName,
	Customers.LastName,
	Customers.Email,
	Customers.Phone,
	Customers.Address
FROM
	Customers
JOIN
	Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY
	Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone, Customers.Address;
--Q4
SELECT
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM
    Products AS P
JOIN
    OrderDetails AS OD ON P.ProductID = OD.ProductID
GROUP BY
    P.ProductName
ORDER BY
    TotalQuantityOrdered DESC;
--Q5
ALTER TABLE Products
ADD Category VARCHAR(50);
Select*from Products;
	SELECT
    ProductID,
    ProductName,
    Description,
    Price,
    Category
FROM
    Products
WHERE
    Category = 'Electronic Gadget';
--Q6
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    AVG(O.TotalAmount) AS AverageOrderValue
FROM
    Customers AS C
JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID, C.FirstName, C.LastName;
--Q7
SELECT
    O.OrderID,
    O.OrderDate,
    O.TotalAmount AS TotalRevenue,
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM
    Orders AS O
JOIN
    Customers AS C ON O.CustomerID = C.CustomerID
ORDER BY
    TotalRevenue DESC
--Q8
SELECT
    P.ProductID,
    P.ProductName,
    COUNT(OD.OrderID) AS OrderCount
FROM
    Products AS P
LEFT JOIN
    OrderDetails AS OD ON P.ProductID = OD.ProductID
WHERE
    P.Category = 'Electronic Gadget'
GROUP BY
    P.ProductID, P.ProductName;
--TASK 5 Q1
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM
    Customers AS C
LEFT JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
WHERE
    O.OrderID IS NULL;
--Q2
select sum([LastStockUpdate])
from [dbo].[Inventory];
--Q3
select sum(TotalAmount) as [total revenue] from Orders
--Q4
SELECT
    P.Category,
    AVG(OD.Quantity) AS AverageQuantityOrdered
FROM
    Products AS P
JOIN
    OrderDetails AS OD ON P.ProductID = OD.ProductID
WHERE
    P.Category = 'Electronic Gadget'
GROUP BY
    P.Category;
--Q5
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    SUM(O.TotalAmount) AS TotalRevenue
FROM
    Customers AS C
JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
WHERE
    C.CustomerID = 1 -- You Can change the customer by changing the customer id
GROUP BY
    C.CustomerID, C.FirstName, C.LastName;
--Q6
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    COUNT(O.OrderID) AS NumberOfOrdersPlaced
FROM
    Customers AS C
JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID, C.FirstName, C.LastName
ORDER BY
    NumberOfOrdersPlaced DESC
--Q7
SELECT P.Category,
SUM(OD.Quantity) AS TotalQuantityOrdered
FROM
    Products AS P
JOIN
    OrderDetails AS OD ON P.ProductID = OD.ProductID
GROUP BY
    P.Category
ORDER BY
    TotalQuantityOrdered DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
--Q8
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    SUM(OD.Quantity * P.Price) AS TotalSpending
FROM
    Customers AS C
JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
JOIN
    OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN
    Products AS P ON OD.ProductID = P.ProductID
WHERE
    P.Category = 'Electronic Gadget'
GROUP BY
    C.CustomerID, C.FirstName, C.LastName
ORDER BY
    TotalSpending DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
--Q9
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    COUNT(O.OrderID) AS NumberOfOrders,
    SUM(O.TotalAmount) AS TotalRevenue,
    AVG(O.TotalAmount) AS AverageOrderValue
FROM
    Customers AS C
LEFT JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID, C.FirstName, C.LastName;
--Q10
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    COUNT(O.OrderID) AS OrderCount
FROM
    Customers AS C
LEFT JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID, C.FirstName, C.LastName;