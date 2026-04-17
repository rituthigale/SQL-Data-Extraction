-- Create Database
CREATE DATABASE courier_db;
USE courier_db;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

-- Branch Table
CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    location VARCHAR(100)
);

-- Staff Table
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(100),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Parcel Table
CREATE TABLE parcel (
    parcel_id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    branch_id INT,
    status VARCHAR(50),
    weight DECIMAL(5,2),
    FOREIGN KEY (sender_id) REFERENCES customers(customer_id),
    FOREIGN KEY (receiver_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Insert Data
INSERT INTO customers VALUES
(1, 'Rutu', 'Pune'),
(2, 'Amit', 'Mumbai'),
(3, 'Sneha', 'Nashik');

INSERT INTO branch VALUES
(101, 'Pune Branch', 'Pune'),
(102, 'Mumbai Branch', 'Mumbai');

INSERT INTO staff VALUES
(201, 'Raj', 101),
(202, 'Priya', 102);

INSERT INTO parcel VALUES
(301, 1, 2, 101, 'Delivered', 2.5),
(302, 2, 3, 102, 'In Transit', 1.2),
(303, 1, 3, 101, 'Pending', 3.0);

-- Queries

-- 1. View Tables
SELECT * FROM customers;
SELECT * FROM branch;
SELECT * FROM parcel;

-- 2. JOIN Query
SELECT 
    p.parcel_id,
    c1.name AS sender,
    c2.name AS receiver,
    p.status
FROM parcel p
JOIN customers c1 ON p.sender_id = c1.customer_id
JOIN customers c2 ON p.receiver_id = c2.customer_id;

-- 3. GROUP BY
SELECT branch_id, COUNT(*) AS total_parcels
FROM parcel
GROUP BY branch_id;

-- 4. Subquery
SELECT name FROM customers
WHERE customer_id IN (
    SELECT sender_id FROM parcel
);

-- 5. INNER JOIN
SELECT p.parcel_id, b.branch_name
FROM parcel p
INNER JOIN branch b ON p.branch_id = b.branch_id;

-- 6. LEFT JOIN
SELECT p.parcel_id, b.branch_name
FROM parcel p
LEFT JOIN branch b ON p.branch_id = b.branch_id;

-- 7. Final Report
SELECT 
    p.parcel_id,
    c1.name AS sender,
    c2.name AS receiver,
    b.branch_name,
    p.status
FROM parcel p
JOIN customers c1 ON p.sender_id = c1.customer_id
JOIN customers c2 ON p.receiver_id = c
