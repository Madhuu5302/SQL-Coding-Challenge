CREATE DATABASE CODING;
USE CODING;
-- Create Vehicle Table
CREATE TABLE Vehicle (
	vehicleID INT PRIMARY KEY,
	make VARCHAR(50),
	model VARCHAR(50),
	year INT,
	dailyRate DECIMAL(8, 2),
	status INT, -- Assuming 1 for available, 0 for not available
	passengerCapacity INT,
	engineCapacity INT
);

-- Insert data into Vehicle Table
INSERT INTO Vehicle VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);
SELECT * FROM VEHICLE;

-- Create Customer Table
CREATE TABLE Customer (
	customerID INT PRIMARY KEY,
	firstName VARCHAR(50),
	lastName VARCHAR(50),
	email VARCHAR(100),
	phoneNumber VARCHAR(15)
);

-- Insert data into Customer Table
INSERT INTO Customer VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');
SELECT * FROM CUSTOMER;

-- Create Lease Table
CREATE TABLE Lease (
	leaseID INT PRIMARY KEY,
	vehicleID INT,
	customerID INT,
	startDate DATE,
	endDate DATE,
	leaseType VARCHAR(10),
	FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
	FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- Insert data into Lease Table
INSERT INTO Lease VALUES
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');
SELECT * FROM LEASE;

-- Create Payment Table
CREATE TABLE Payment (
	paymentID INT PRIMARY KEY,
	leaseID INT,
	paymentDate DATE,
	amount DECIMAL(8, 2),
	FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);
UPDATE Lease
SET endDate = '2023-12-30'
WHERE customerID = (SELECT customerID FROM Customer WHERE firstName = 'David');

SELECT * FROM LEASE;



-- Insert data into Payment Table
INSERT INTO Payment VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);
SELECT * FROM PAYMENT;

--Q1
UPDATE Vehicle
SET dailyRate = 68.00
WHERE make = 'Mercedes';
SELECT * FROM VEHICLE;
--Q2
-- Delete payments related to the customer
DELETE FROM Payment
WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID = (SELECT customerID FROM Customer WHERE email = 'olivia@example.com'));

-- Delete leases related to the customer
DELETE FROM Lease
WHERE customerID = (SELECT customerID FROM Customer WHERE email = 'olivia@example.com');

-- Delete the customer
DELETE FROM Customer
WHERE email = 'olivia@example.com';
SELECT * FROM CUSTOMER;
SELECT * FROM LEASE;
SELECT * FROM PAYMENT;
--Q3
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';
--Q4
SELECT * FROM Customer
WHERE email = 'sarah@example.com';
--Q5
SELECT *
FROM Lease
WHERE customerID = (SELECT customerID FROM Customer WHERE email = 'david@example.com')
AND endDate >= GETDATE();
--Q6
SELECT Payment.*, Lease.startDate, Lease.endDate, Vehicle.make, Vehicle.model
FROM Payment
JOIN Lease ON Payment.leaseID = Lease.leaseID
JOIN Customer ON Lease.customerID = Customer.customerID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE Customer.phoneNumber = '555-987-6543';
--Q7
SELECT AVG(dailyRate) AS averageDailyRate
FROM Vehicle
WHERE status = 1;
--Q8
SELECT *
FROM Vehicle
ORDER BY dailyRate DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
--Q9
SELECT Vehicle.*
FROM Vehicle
JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
JOIN Customer ON Lease.customerID = Customer.customerID
WHERE Customer.email = 'johndoe@example.com';
--Q10
SELECT Lease.*, Vehicle.make, Vehicle.model, Customer.firstName, Customer.lastName
FROM Lease
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
JOIN Customer ON Lease.customerID = Customer.customerID
ORDER BY Lease.startDate DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
--Q11
SELECT *
FROM Payment
WHERE YEAR(paymentDate) = 2023;
--Q12
SELECT Customer.*
FROM Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
WHERE Payment.paymentID IS NULL;
--Q13
SELECT
	Vehicle.vehicleID,
	Vehicle.make,
	Vehicle.model,
	SUM(Payment.amount) AS totalPayments
FROM
	Vehicle
JOIN
	Lease ON Vehicle.vehicleID = Lease.vehicleID
JOIN
	Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
	Vehicle.vehicleID, Vehicle.make, Vehicle.model;
--Q14
SELECT
	Customer.customerID,
	Customer.firstName,
	Customer.lastName,
	SUM(Payment.amount) AS totalPayments
FROM
	Customer
LEFT JOIN
	Lease ON Customer.customerID = Lease.customerID
LEFT JOIN
	Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
	Customer.customerID, Customer.firstName, Customer.lastName;
--Q15
SELECT
	Lease.leaseID,
	Vehicle.make,
	Vehicle.model,
	Vehicle.year,
	Lease.startDate,
	Lease.endDate,
	Lease.leaseType
FROM
	Lease
JOIN
	Vehicle ON Lease.vehicleID = Vehicle.vehicleID;
--Q16
SELECT
	Lease.leaseID,
	Customer.firstName,
	Customer.lastName,
	Vehicle.make,
	Vehicle.model,
	Lease.startDate,
	Lease.endDate,
	Lease.leaseType
FROM
	Lease
JOIN
	Customer ON Lease.customerID = Customer.customerID
JOIN
	Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE
	Lease.endDate >= GETDATE();
--Q17
SELECT
	Customer.customerID,
	Customer.firstName,
	Customer.lastName,
	SUM(Payment.amount) AS totalPayments
FROM
	Customer
JOIN
	Lease ON Customer.customerID = Lease.customerID
JOIN
	Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
	Customer.customerID, Customer.firstName, Customer.lastName
ORDER BY
	totalPayments DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
--Q18
SELECT
	Vehicle.vehicleID,
	Vehicle.make,
	Vehicle.model,
	Vehicle.year,
	Lease.leaseID,
	Lease.startDate,
	Lease.endDate,
	Lease.leaseType,
	Customer.firstName,
	Customer.lastName,
	Customer.email,
	Customer.phoneNumber
FROM
	Vehicle
LEFT JOIN
	Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN
	Customer ON Lease.customerID = Customer.customerID
WHERE
	Lease.endDate >= GETDATE() OR Lease.endDate IS NULL;















