-- Create Customers Table
CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	name VARCHAR(255),
	email VARCHAR(255),
	password VARCHAR(255)
);

-- Create Products Table
CREATE TABLE products (
	product_id INT PRIMARY KEY,
	name VARCHAR(255),
	description VARCHAR(255),
	price DECIMAL(10, 2),
	stock_quantity INT
);

-- Create Cart Table
CREATE TABLE cart (
	cart_id INT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	quantity INT,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Orders Table
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	total_price DECIMAL(10, 2),
	shipping_address VARCHAR(255),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Order_Items Table
CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY,
	order_id INT,
	product_id INT,
	quantity INT,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);





-- Insert data into Customers Table
INSERT INTO customers VALUES
	(1, 'John Doe', 'johndoe@example.com', 'password1'),
	(2, 'Jane Smith', 'janesmith@example.com', 'password2'),
	(3, 'Robert Johnson', 'robert@example.com', 'password3'),
	(4, 'Sarah Brown', 'sarah@example.com', 'password4'),
	(5, 'David Lee', 'david@example.com', 'password5'),
	(6, 'Laura Hall', 'laura@example.com', 'password6'),
	(7, 'Michael Davis', 'michael@example.com', 'password7'),
	(8, 'Emma Wilson', 'emma@example.com', 'password8'),
	(9, 'William Taylor', 'william@example.com', 'password9'),
	(10, 'Olivia Adams', 'olivia@example.com', 'password10');
SELECT * FROM CUSTOMERS;
-- Insert data into Products Table
INSERT INTO products VALUES
	(1, 'Laptop', 'High-performance laptop', 800.00, 10),
	(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
	(3, 'Tablet', 'Portable tablet', 300.00, 20),
	(4, 'Headphones', 'Noise-canceling', 150.00, 30),
	(5, 'TV', '4K Smart TV', 900.00, 5),
	(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
	(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
	(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
	(9, 'Blender', 'High-speed blender', 70.00, 20),
	(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);
SELECT * FROM PRODUCTS;
-- Insert data into Cart Table
INSERT INTO cart VALUES
	(1, 1, 1, 2),
	(2, 1, 3, 1),
	(3, 2, 2, 3),
	(4, 3, 4, 4),
	(5, 3, 5, 2),
	(6, 4, 6, 1),
	(7, 5, 1, 1),
	(8, 6, 10, 2),
	(9, 6, 9, 3),
	(10, 7, 7, 2);
SELECT * FROM CART;
-- Insert data into Orders Table
INSERT INTO orders VALUES
	(1, 1, '2023-01-05', 1200.00, '123 Main St, City'),
	(2, 2, '2023-02-10', 900.00, '456 Elm St, Town'),
	(3, 3, '2023-03-15', 300.00, '789 Oak St, Village'),
	(4, 4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
	(5, 5, '2023-05-25', 1800.00, '234 Cedar St, District'),
	(6, 6, '2023-06-30', 400.00, '567 Birch St, County'),
	(7, 7, '2023-07-05', 700.00, '890 Maple St, State'),
	(8, 8, '2023-08-10', 160.00, '321 Redwood St, Country'),
	(9, 9, '2023-09-15', 140.00, '432 Spruce St, Province'),
	(10, 10, '2023-10-20', 1400.00, '765 Fir St, Territory');
SELECT * FROM  ORDERS;

ALTER TABLE products ADD category VARCHAR(255);
SELECT * FROM PRODUCTS;
UPDATE products
SET category = 'Electronics' WHERE product_id IN (1, 2, 3, 4, 5);
UPDATE products
SET category = 'Appliances' WHERE product_id IN (6, 7, 8, 9, 10);
SELECT * FROM PRODUCTS;
SELECT * FROM customers;

--q1
UPDATE products
SET price = 800.00
WHERE product_id = 7;
SELECT * FROM PRODUCTS;
--q2
DELETE FROM cart
WHERE customer_id = 2;
SELECT * FROM CART;
--q3
SELECT *
FROM products
WHERE price < 100.00;
--q4
SELECT *
FROM products
WHERE stock_quantity > 5;
--q5
SELECT *
FROM orders
WHERE total_price BETWEEN 500.00 AND 1000.00;
--q6
SELECT *
FROM products
WHERE name LIKE '%r';
--q7
SELECT *
FROM cart
WHERE customer_id = 5;
--q8
SELECT *
FROM customers
WHERE customer_id IN (
	SELECT DISTINCT customer_id
	FROM orders
	WHERE YEAR(order_date) = 2023
);
--q9
SELECT category, MIN(stock_quantity) AS min_stock_quantity
FROM products
GROUP BY category;
--q10
SELECT
	c.customer_id,
	c.name AS customer_name,
	COALESCE(SUM(o.total_price), 0) AS total_amount_spent
FROM
	customers c
LEFT JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id, c.name;
--q11
SELECT
	c.customer_id,
	c.name AS customer_name,
	AVG(o.total_price) AS average_order_amount
FROM
	customers c
LEFT JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id, c.name;
--q12
SELECT
	c.customer_id,
	c.name AS customer_name,
	COUNT(o.order_id) AS order_count
FROM
	customers c
LEFT JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id, c.name;
--q13
SELECT
	c.customer_id,
	c.name AS customer_name,
	MAX(o.total_price) AS max_order_amount
FROM
	customers c
LEFT JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id, c.name;
--q14
SELECT
	c.customer_id,
	c.name AS customer_name,
	SUM(o.total_price) AS total_order_amount
FROM
	customers c
JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id, c.name
HAVING
	SUM(o.total_price) > 1000;
--q15
SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM cart
);
--q16
	SELECT *
FROM customers
WHERE customer_id NOT IN (
	SELECT DISTINCT customer_id
	FROM orders
);
--q17
SELECT
	product_id,
	name,
	price,
	total_revenue,
	(total_revenue / SUM(total_revenue) OVER () * 100) AS percentage_of_total_revenue
FROM (
	SELECT
    	p.product_id,
    	p.name,
    	p.price,
    	SUM(oi.quantity * p.price) AS total_revenue
	FROM
    	products p
	LEFT JOIN
    	order_items oi ON p.product_id = oi.product_id
	GROUP BY
    	p.product_id, p.name, p.price
) AS product_revenue;
--q18

SELECT *
FROM products
WHERE stock_quantity < (SELECT AVG(stock_quantity) FROM products);
--q19
SELECT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_price = (
	SELECT MAX(total_price)
	FROM orders
);





