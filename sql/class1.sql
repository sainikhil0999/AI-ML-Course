USE sakila;

-- --------------------------------------------------
-- 1. SELECT
-- --------------------------------------------------

SELECT * 
FROM actor;                               -- shows all rows and columns

SELECT DISTINCT first_name 
FROM actor;                               -- shows unique first names only

SELECT * 
FROM film
WHERE original_language_id IS NULL;       -- rows where original_language_id is null

SELECT COUNT(*) 
FROM film;                                -- total number of rows in film table

SELECT * 
FROM film;                                -- all film data

SELECT DISTINCT title 
FROM film
WHERE original_language_id IS NULL;       -- unique titles where original_language_id is null

SELECT COUNT(DISTINCT title) 
FROM film;                                -- count of unique film titles


-- --------------------------------------------------
-- 2. COUNT and DISTINCT COUNT
-- --------------------------------------------------

SELECT COUNT(first_name) 
FROM actor;                               -- counts non-null first_name values

SELECT COUNT(DISTINCT first_name) 
FROM actor;                               -- counts unique first names


-- --------------------------------------------------
-- 3. SELECT SPECIFIC COLUMNS
-- --------------------------------------------------

SELECT first_name, last_name
FROM actor;                               -- only selected columns


-- --------------------------------------------------
-- 4. LIMIT
-- --------------------------------------------------

SELECT first_name, last_name
FROM actor
LIMIT 100;                                -- only first 100 rows


-- --------------------------------------------------
-- 5. FILTERING WITH WHERE
-- --------------------------------------------------

SELECT DISTINCT rating
FROM film;                                -- unique ratings

SELECT * 
FROM film;

SELECT * 
FROM film
WHERE rating = 'R' 
  AND length >= 92;                       -- rating R and length 92 or more

SELECT * 
FROM film
WHERE length >= 92;                       -- films with length 92 or more


-- --------------------------------------------------
-- 6. SORTING
-- --------------------------------------------------

SELECT rental_rate
FROM film;

SELECT rental_rate
FROM film
ORDER BY rental_rate DESC;                -- highest rental rate first


-- --------------------------------------------------
-- 7. AND / OR OPERATORS
-- --------------------------------------------------

SELECT * 
FROM film
WHERE rating = 'PG' 
  AND rental_duration = 5
ORDER BY rental_rate ASC;                 -- both conditions must match

SELECT * 
FROM film
WHERE rating = 'PG' 
   OR rental_duration = 5
ORDER BY rental_rate ASC;                 -- any one condition can match


-- --------------------------------------------------
-- 8. NOT
-- --------------------------------------------------

SELECT * 
FROM film
WHERE rental_duration NOT IN (6, 7, 3)
ORDER BY rental_rate ASC;                 -- excluding 6, 7, 3

SELECT * 
FROM film
WHERE NOT rental_duration = 6
ORDER BY rental_rate ASC;                 -- all except rental_duration 6


-- --------------------------------------------------
-- 9. USING BRACKETS WITH CONDITIONS
-- --------------------------------------------------

SELECT * 
FROM film
WHERE rental_duration = 6
  AND (rating = 'G' OR rating = 'PG')
ORDER BY rental_rate ASC;                 -- rental duration 6 and rating G or PG


-- --------------------------------------------------
-- 10. LIKE
-- %  = zero, one, or many characters
-- _  = exactly one character
-- --------------------------------------------------

SELECT city
FROM city
WHERE city LIKE '%s%';                    -- city contains s anywhere

SELECT city
FROM city
WHERE city LIKE '_s_a_%';                 -- pattern match with single characters


-- --------------------------------------------------
-- 11. NULL VALUES
-- --------------------------------------------------

SELECT * 
FROM rental;

SELECT rental_id, inventory_id, customer_id, return_date
FROM rental
WHERE return_date IS NULL;                -- rentals not returned yet


-- --------------------------------------------------
-- 12. BETWEEN
-- --------------------------------------------------

SELECT rental_id, inventory_id, customer_id, return_date
FROM rental
WHERE return_date BETWEEN '2005-05-26' AND '2005-05-30';   -- date range


-- --------------------------------------------------
-- 13. GROUP BY and HAVING
-- --------------------------------------------------

SELECT customer_id,
       COUNT(*) AS count_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(*) >= 30
ORDER BY count_rentals DESC;              -- customers with 30 or more rentals


-- --------------------------------------------------
-- 14. ORDER OF EXECUTION IN SQL
-- FROM -> JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
-- --------------------------------------------------


-- --------------------------------------------------
-- 15. DIFFERENCE BETWEEN WHERE and HAVING
-- WHERE filters rows before grouping
-- HAVING filters groups after grouping
-- --------------------------------------------------

SELECT * 
FROM rental
WHERE return_date IS NULL;                -- row-level filtering

SELECT * 
FROM rental
WHERE customer_id = 33;                   -- row-level filtering

SELECT * 
FROM payment;

SELECT customer_id,
       SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100
   AND customer_id BETWEEN 1 AND 100;     -- group-level filtering