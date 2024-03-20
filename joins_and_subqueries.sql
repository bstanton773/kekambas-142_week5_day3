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


