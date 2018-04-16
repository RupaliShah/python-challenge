USE sakila;

SELECT first_name, last_name FROM actor;

SELECT CONCAT (first_name, '  ', last_name) AS ACTOR_NAME FROM actor;

SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";

SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%gen%";

SELECT last_name, first_name FROM actor
WHERE last_name LIKE "%li%";

SELECT country_id, country FROM country
WHERE country IN ("Afghanistan","Bangladesh","China");

ALTER TABLE ACTOR 
ADD COLUMN middle_name VARCHAR(30) AFTER first_name;

ALTER TABLE actor
MODIFY middle_name BLOB;

ALTER TABLE actor
DROP COLUMN middle_name;

SELECT last_name, count(*) FROM ACTOR
GROUP BY last_name;

SELECT last_name AS `Last Name`, count(*) AS `Number of Actors`
FROM actor 
GROUP BY last_name 
HAVING count(last_name) >= 2;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

UPDATE actor 
SET first_name = 
CASE
	WHEN first_name = "HARPO" THEN "Groucho"
ELSE
	"MUCHO GROUCHO"	
END
WHERE actor_id = 172;


SHOW CREATE TABLE address;


SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON address.address_id = staff.address_id;


SELECT staff.username AS `Staff Member`, SUM(payment.amount) AS `August Amount`
FROM STAFF
JOIN payment WHERE payment.staff_id = staff.staff_id
AND payment.payment_date BETWEEN '2005-08-01 00:00:00' AND '2005-08-31 23:59:00'
GROUP BY staff.username;


SELECT film.title AS Film, count(*) AS `Number of Actors`
FROM film
INNER JOIN film_actor on film.film_id = film_actor.film_id
group by title;


SELECT count(*) AS `Number of Copies of 'Hunchback Impossible'` FROM inventory WHERE film_id IN
(
	SELECT film_id FROM film
    WHERE film.title = 'Hunchback Impossible'
);


SELECT customer.first_name, customer.last_name, sum(payment.amount) AS `Total Amount Paid`
FROM customer
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.last_name;


SELECT title AS `English Movies Starting with K and Q` FROM film 
WHERE title LIKE 'K%' OR title like 'Q%' AND language_id IN
(
	SELECT language_id from language where name = "English"
);


SELECT CONCAT(first_name, ' ', last_name) AS `Actors in 'Alone Trip'` FROM actor WHERE actor_id IN
(
	SELECT actor_id FROM film_actor WHERE film_id IN
    (
			SELECT film_id FROM film WHERE title = 'Alone Trip'
	)
);


SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS `Canadian Customers`, customer.email 
FROM customer 
JOIN address ON address.address_id = customer.address_id
JOIN city ON city.city_id = address.city_id 
JOIN country ON country.country_id = city.country_id AND country.country = 'CANADA';


SELECT title AS `Family Films` FROM film WHERE film_id IN 
(	
    SELECT film_id FROM film_category WHERE category_id IN
	(
		SELECT category_id FROM category WHERE name = 'Family'
	)
);


SELECT film.title AS `Most Frequently Rented Movies`	
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY count(rental_id) DESC;


SELECT store.store_id, SUM(payment.amount) AS `Earnings($)`
FROM store 
JOIN customer ON customer.store_id = store.store_id
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY store.store_id;


SELECT store.store_id, city.city, country.country
FROM store
JOIN customer ON customer.store_id = store.store_id
JOIN address ON address.address_id = customer.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id;

  
SELECT category.name AS Genre, SUM(payment.amount) AS `Gross Revenue` 
FROM payment 
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id 
GROUP BY Genre
ORDER BY `Gross Revenue` DESC LIMIT 5;


CREATE VIEW top_genres_by_revenue AS 
SELECT category.name AS Genre, SUM(payment.amount) AS `Gross Revenue`
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id 
GROUP BY Genre
ORDER BY `Gross Revenue` DESC LIMIT 5;


SELECT * from top_genres_by_revenue;

DROP VIEW IF EXISTS top_genres_by_revenue;