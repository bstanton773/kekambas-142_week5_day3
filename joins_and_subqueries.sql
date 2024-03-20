SELECT *
FROM film;

SELECT *
FROM actor;


SELECT *
FROM film_actor;


-- Join between the film and film_actor table
SELECT *
FROM film_actor fa
JOIN film f
ON f.film_id = fa.film_id;

-- Join between the actor and film_actor table
SELECT *
FROM film_actor fa
JOIN actor a
ON a.actor_id = fa.actor_id;


-- Multi Join
SELECT a.first_name, a.last_name, a.actor_id, fa.actor_id, fa.film_id, f.film_id, f.title, f.description
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f
ON f.film_id = fa.film_id;


-- Display Customer name and film that they rented -- customer -> rental -> inventory -> film
SELECT c.first_name, c.last_name, c.customer_id, r.customer_id, r.rental_id, r.inventory_id, i.inventory_id, i.film_id, f.film_id, f.title
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id;

-- WE can still all of the other Fun DQL clauses
SELECT c.first_name, c.last_name, c.customer_id, r.customer_id, r.rental_id, r.inventory_id, i.inventory_id, i.film_id, f.film_id, f.title
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
WHERE c.first_name LIKE 'R%'
ORDER BY f.title
LIMIT 10
OFFSET 5;


-- Subqueries!!!
-- Subquery - A query within a query

-- Example: Which films have exactly 12 actors in it

-- Step 1. Find the film_ids from the film_actor table that have a count of 12
SELECT film_id, COUNT(*)
FROM film_actor
GROUP BY film_id
HAVING COUNT(*) = 12;

--film_id|
-- ------+
--    529|
--    802|
--     34|
--    892|
--    414|
--    517|

-- Step 2. Query the film table for films that match those IDS
SELECT *
FROM film
WHERE film_id IN (
	529,
	802,
	34,
	892,
	414,
	517
);


-- Put the two steps together into a subquery
-- The query that we want to execute first is the subquery
-- ** Subquery must return only ONE column **      *unless used in a FROM clause
SELECT *
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*) = 12
);


SELECT *
FROM film
JOIN (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*) = 12
) AS temp_table
ON temp_table.film_id = film.film_id;


-- Subquery vs Join
-- Which employee has sold the most rentals (use the rental table)
SELECT *
FROM staff
WHERE staff_id = (
	SELECT staff_id
	FROM rental
	GROUP BY staff_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

SELECT s.staff_id, first_name, last_name, COUNT(*)
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id 
GROUP BY s.staff_id
ORDER BY COUNT(*) DESC;


-- Use subqueries for calculations
-- Find all of the payments that are more than the average payment

SELECT *
FROM payment p 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);



-- Subqueries with the FROM clause
-- *Subquery in a FROM must be in parenteses - alias optional (as of Postgresql 16)*

-- Find the average number of rentals per customer

-- Step 1. Get the count for each customer
SELECT customer_id, COUNT(*) AS num_rentals
FROM rental
GROUP BY customer_id;

-- Step 2. Use the temp table from step 1 as the table to find the average via subquery
SELECT AVG(num_rentals)
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental
	GROUP BY customer_id
) AS customer_rental_totals;


-- Other DQL clauses still work
SELECT *
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental
	GROUP BY customer_id
)
WHERE num_rentals > 40
ORDER BY num_rentals;


-- Subqueries can also be used in DML statements

-- setup -> add loyalty_member column with Boolean datatype
ALTER TABLE customer
ADD COLUMN loyalty_member BOOLEAN;

-- Set the loyalty_member column to False for all customers
UPDATE customer
SET loyalty_member = FALSE;

SELECT *
FROM customer;

-- Update the customer table and set any customer who has over 25 rentals to be a loyalty_member

-- Step 1. Find all the customer IDs of those customer who have rented 25+ films
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(*) >= 25;


-- Step 2. Make an update statement and update all customers with those IDs
UPDATE customer 
SET loyalty_member = TRUE
WHERE customer_id IN (
	SELECT customer_id
	FROM rental
	GROUP BY customer_id
	HAVING COUNT(*) >= 25
);


SELECT loyalty_member, COUNT(*)
FROM customer
GROUP BY loyalty_member;
