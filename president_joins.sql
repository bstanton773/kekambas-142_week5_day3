-- DDL Statements to create the tables

-- Customer table
CREATE TABLE IF NOT EXISTS customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	address VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(2)
);

SELECT *
FROM customer;


-- Create Receipt Table
CREATE TABLE receipt (
	receipt_id SERIAL PRIMARY KEY,
	amount NUMERIC(5,2), -- Max of 5 total digits, 2 digit to the right of the decimal (XXX.XX)
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL
);

SELECT *
FROM receipt;


-- DML Statements to Add data into the tables 
INSERT INTO customer(first_name, last_name, email, address, city, state)
VALUES('George', 'Washington', 'firstpres@usa.gov', '3200 Mt. Vernon Way', 'Mt. Vernon', 'VA'),
('John', 'Adams', 'jadams@whitehouse.org', '1234 W Presidential Place', 'Quincy', 'MA'),
('Thomas', 'Jefferson', 'iwrotethedeclaration@freeamerica.org', '555 Independence Drive', 'Charleston', 'VA'),
('James', 'Madison', 'fatherofconstitution@prez.io', '8345 E Eastern Ave', 'Richmond', 'VA'),
('James', 'Monroe', 'jmonroe@usa.gov', '3682 N Monroe Parkway', 'Chicago', 'IL');

SELECT *
FROM customer;

-- Add some data to the receipt table
INSERT INTO receipt(amount, customer_id)
VALUES (99.99, 1);

INSERT INTO receipt(amount, customer_id)
VALUES (55.43, 3);

INSERT INTO receipt(amount, customer_id)
VALUES (325.98, 1);

INSERT INTO receipt(amount, customer_id)
VALUES (45.45, 2);

INSERT INTO receipt(amount, customer_id)
VALUES (123.45, null);

INSERT INTO receipt(amount, customer_id)
VALUES (543.21, null);

SELECT * 
FROM receipt;


-- Get the information about Customer ID 1
SELECT *
FROM customer 
WHERE customer_id = 1;

SELECT *
FROM receipt
WHERE customer_id = 1;

-- Using Joins, we can combine the tables together on a common field (FK <-> PK)
-- Syntax:
-- SELECT col_1, col_2, etc. (can be from either table)
-- FROM table_name_1 (will be considered the LEFT table)
-- JOIN table_name_2 (will be considered the RIGHT table)
-- ON table_name_1.col_name = table_name_2.col_name (where col_name is FK to other col_name PK)


-- Inner Join
SELECT *
FROM customer
JOIN receipt
ON customer.customer_id = receipt.customer_id;


SELECT first_name, last_name, c.customer_id AS cust_cust_id, r.customer_id AS rec_cust_id, receipt_id, order_date, amount
FROM customer c
JOIN receipt r 
ON c.customer_id = r.customer_id; 


-- Each Join

-- JOIN or INNER JOIN - returns records that have matching values in both tables
SELECT *
FROM customer c
JOIN receipt r
ON c.customer_id = r.customer_id;


-- FULL JOIN - Return all records from both tables, will match if available, otherwise display NULL
SELECT *
FROM customer c
FULL JOIN receipt r
ON c.customer_id = r.customer_id;

-- LEFT JOIN - Return all records from the left, and only matching data from the right table
SELECT *
FROM customer c -- LEFT table
LEFT JOIN receipt r  -- RIGHT table
ON c.customer_id = r.customer_id;

-- RIGHT JOIN - Return all records from the right, and only matching data from the left table
SELECT *
FROM customer c -- LEFT table
RIGHT JOIN receipt r  -- RIGHT table
ON c.customer_id = r.customer_id;

-- Right Join again - flip-flop right and left table
SELECT *
FROM  receipt r-- LEFT table
RIGHT JOIN customer c  -- RIGHT table
ON c.customer_id = r.customer_id;

-- JOIN...ON comes after the SELECT...FROM and before WHERE

--SELECT
--FROM
--JOIN
--ON
--WHERE
--GROUP BY
--HAVING
--ORDER BY
--LIMIT
--OFFSET

SELECT *
FROM customer
JOIN receipt
ON customer.customer_id = receipt.customer_id
WHERE state = 'VA';


SELECT customer_id, SUM(amount)
FROM receipt 
GROUP BY customer_id;

SELECT customer.customer_id, first_name, last_name, SUM(amount), COUNT(*)
FROM receipt 
JOIN customer
ON customer.customer_id = receipt.customer_id 
GROUP BY customer.customer_id;


SELECT c.customer_id, first_name, last_name, SUM(amount)
FROM customer c
JOIN receipt r
ON c.customer_id = r.customer_id 
GROUP BY c.customer_id;


-- Aliasing Table Names - unambiguous column names

CREATE TABLE teacher (
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR
);

CREATE TABLE student (
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR,
	teacher_id INTEGER NOT NULL,
	FOREIGN KEY(teacher_id) REFERENCES teacher(teacher_id)
);

INSERT INTO teacher (first_name, last_name)
VALUES ('Brian', 'Stanton'), ('Travis', 'Peck'), ('Kevin', 'Beier');

INSERT INTO student(first_name, last_name, teacher_id)
VALUES ('Jimmy', 'Smith', 1), ('Freddy', 'Franks', 2), ('Sally', 'Sallerson', 1), ('Ellie', 'McEllson', 2);

SELECT *
FROM teacher;

SELECT *
FROM student;


SELECT s.first_name, s.last_name, t.first_name, t.last_name
FROM student s
JOIN teacher t
ON s.teacher_id = t.teacher_id;