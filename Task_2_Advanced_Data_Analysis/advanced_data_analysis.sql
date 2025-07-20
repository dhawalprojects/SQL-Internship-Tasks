use sakila;
-- 1. Rank customers by total amount spent
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 2. Running total of rentals per day
SELECT DATE(rental_date) AS day, COUNT(*) AS rentals_on_day,
       SUM(COUNT(*)) OVER (ORDER BY DATE(rental_date)) AS running_total
FROM rental
GROUP BY DATE(rental_date);

-- 3. Films rented more than the average number of times
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
HAVING COUNT(r.rental_id) > (
    SELECT AVG(film_rentals) FROM (
        SELECT COUNT(r2.rental_id) AS film_rentals
        FROM film f2
        JOIN inventory i2 ON f2.film_id = i2.film_id
        JOIN rental r2 ON i2.inventory_id = r2.inventory_id
        GROUP BY f2.film_id
    ) sub
);

-- 4. Actors with more than 20 films
WITH ActorFilmCount AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
)
SELECT * FROM ActorFilmCount WHERE film_count > 20 ORDER BY film_count DESC;

-- 5. For each customer, their rentals and the order in which they rented
WITH CustomerRentals AS (
    SELECT r.*, c.first_name, c.last_name
    FROM rental r
    JOIN customer c ON r.customer_id = c.customer_id
)
SELECT customer_id, first_name, last_name, rental_date,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_date) AS rental_order
FROM CustomerRentals;

-- 6. Each film's title, number of rentals, and average rental duration (in days)
SELECT f.title,
       (SELECT COUNT(*) FROM inventory i JOIN rental r ON i.inventory_id = r.inventory_id WHERE i.film_id = f.film_id) AS num_rentals,
       (SELECT AVG(DATEDIFF(r.return_date, r.rental_date)) FROM inventory i JOIN rental r ON i.inventory_id = r.inventory_id WHERE i.film_id = f.film_id) AS avg_rental_duration
FROM film f;

-- 7. Average payment amount per customer
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_paid,
       AVG(SUM(p.amount)) OVER () AS avg_paid_per_customer
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;
