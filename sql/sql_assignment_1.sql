USE sakila;

-- 1. Get all customers whose first name starts with 'J' and who are active.
SELECT *
FROM customer
WHERE first_name LIKE 'J%'          -- name starts with J
  AND active = 1;                   -- only active customers


-- 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
SELECT *
FROM film
WHERE title LIKE '%ACTION%'         -- title has ACTION
   OR description LIKE '%WAR%';     -- description has WAR


-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
SELECT *
FROM customer
WHERE last_name <> 'SMITH'          -- not SMITH
  AND first_name LIKE '%a';         -- first name ends with a


-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
SELECT *
FROM film
WHERE rental_rate > 3.0             -- rental rate greater than 3
  AND replacement_cost IS NOT NULL; -- replacement cost should not be null


-- 5. Count how many customers exist in each store who have active status = 1.
SELECT store_id,
       COUNT(*) AS active_customer_count
FROM customer
WHERE active = 1                    -- only active customers
GROUP BY store_id;                  -- count for each store


-- 6. Show distinct film ratings available in the film table.
SELECT DISTINCT rating
FROM film;                          -- distinct removes duplicates


-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
SELECT rental_duration,
       COUNT(*) AS film_count,
       AVG(length) AS avg_length
FROM film
GROUP BY rental_duration
HAVING AVG(length) > 100;           -- filter grouped result


-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
SELECT DATE(payment_date) AS payment_day,
       SUM(amount) AS total_amount,
       COUNT(*) AS payment_count
FROM payment
GROUP BY DATE(payment_date)         -- grouping by only date part
HAVING COUNT(*) > 100;              -- only days with more than 100 payments


-- 9. Find customers whose email address is null or ends with '.org'.
SELECT *
FROM customer
WHERE email IS NULL
   OR email LIKE '%.org';           -- email ends with .org


-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
SELECT *
FROM film
WHERE rating IN ('PG', 'G')         -- only PG and G
ORDER BY rental_rate DESC;          -- highest rental rate first


-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
SELECT length,
       COUNT(*) AS film_count
FROM film
WHERE title LIKE 'T%'               -- title starts with T
GROUP BY length
HAVING COUNT(*) > 5;                -- only groups with count more than 5


-- 12. List all actors who have appeared in more than 10 films.
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa
  ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;      -- actors in more than 10 films


-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
SELECT film_id,
       title,
       rental_rate,
       length
FROM film
ORDER BY rental_rate DESC,          -- first highest rental rate
         length DESC                -- then highest length
LIMIT 5;


-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r
  ON c.customer_id = r.customer_id  -- keep all customers
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC;        -- highest rentals first


-- 15. List the film titles that have never been rented.
SELECT f.title
FROM film f
LEFT JOIN inventory i
  ON f.film_id = i.film_id
LEFT JOIN rental r
  ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;          -- no rental means never rented