-- 1. INNER JOIN: Films and their actors
SELECT f.title, a.first_name, a.last_name
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id;

-- 2. LEFT JOIN: All customers and their most recent rental (if any)
SELECT c.first_name, c.last_name, MAX(r.rental_date) AS last_rental
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 3. RIGHT JOIN: Films and the customers who rented them (if any)
SELECT f.title, c.first_name, c.last_name
FROM film f
RIGHT JOIN inventory i ON f.film_id = i.film_id
RIGHT JOIN rental r ON i.inventory_id = r.inventory_id
RIGHT JOIN customer c ON r.customer_id = c.customer_id;

-- 4. FULL OUTER JOIN: Stores and staff (if supported by your SQL engine)
SELECT s.store_id, st.staff_id, st.first_name, st.last_name
FROM store s
LEFT JOIN staff st ON s.store_id = st.store_id
UNION
SELECT s.store_id, st.staff_id, st.first_name, st.last_name
FROM staff st
LEFT JOIN store s ON st.store_id = s.store_id;

-- 5. Films and number of times rented
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id;

-- 6. Customers who have never rented a film
SELECT c.first_name, c.last_name
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;

-- 7. Films never rented
SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;
