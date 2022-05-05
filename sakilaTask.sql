--List all actors.
SELECT * FROM actor;

--Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor WHERE first_name = 'John';

--Find all actors with surname 'Neeson'.
SELECT first_name, last_name FROM actor WHERE last_name = 'Neeson';

--Find all actors with ID numbers divisible by 10.
SELECT first_name, last_name FROM actor WHERE actor_id % 10 = 0;

--What is the description of the movie with an ID of 100?
SELECT description FROM nicer_but_slower_film_list WHERE FID = 100;

--Find every R-rated movie.
SELECT title FROM nicer_but_slower_film_list WHERE rating = 'R';

--Find every non-R-rated movie.
SELECT title FROM nicer_but_slower_film_list WHERE rating != 'R';

--Find the ten shortest movies.
SELECT * FROM film ORDER BY length ASC LIMIT 10;

--Find the movies with the longest runtime, without using LIMIT.
SELECT title, length
FROM film
WHERE length= (
	SELECT max(length)
	FROM film
);

--Find all movies that have deleted scenes.
SELECT title FROM film WHERE special_features = 'Deleted Scenes';

--Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT DISTINCT last_name
FROM actor
HAVING last_name IS NOT NULL
ORDER BY last_name DESC;

--Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1
ORDER BY COUNT(last_name) DESC;

--Which actor has appeared in the most films?

SELECT first_name, last_name
FROM actor_info
JOIN film_actor ON actor_info.actor_id=film_actor.actor_id
GROUP BY actor_info.actor_id
ORDER BY COUNT(*) DESC
LIMIT 1;

--'Academy Dinosaur' has been rented out, when is it due to be returned?

SELECT return_date
FROM rental
LEFT OUTER JOIN inventory ON inventory.inventory_id=rental.inventory_id
LEFT OUTER JOIN film ON film.film_id=inventory.film_id
WHERE film.title = "Academy Dinosaur" 
GROUP BY rental.rental_date
ORDER BY COUNT(*) DESC
LIMIT 1;

--correct way
SELECT film.title, DATE_ADD(rental.rental_date, INTERVAL film.rental_duration DAY) AS due_date
FROM film
LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
LEFT OUTER JOIN rental ON rental.inventory_id = inventory.inventory_id
WHERE film.title = "Academy Dinosaur"
AND rental.return_date IS NULL
AND rental.rental_date IS NOT NULL;

--What is the average runtime of all films?

SELECT AVG(length)
FROM film;

--List the average runtime for every film category.

SELECT AVG(length), category_id
FROM film
LEFT OUTER JOIN film_category ON film.film_id = film_category.film_id
GROUP BY category_id;

--List all movies featuring a robot.

SELECT title
FROM film_text
WHERE description LIKE '%robot%';

--How many movies were released in 2010?

SELECT COUNT(*) 
FROM film
WHERE release_year = 2010;

--OR
SELECT COUNT(release_year) AS 2010_films
FROM film
WHERE release_year=2010;

--Find the titles of all the horror movies.

SELECT title
FROM film
LEFT OUTER JOIN film_category ON film.film_id=film_category.film_id
LEFT OUTER JOIN category ON category.category_id=film_category.category_id
WHERE category.name = 'Horror';

--List the full name of the staff member with the ID of 2.

SELECT first_name, last_name
FROM staff
WHERE staff_id = 2;

--List all the movies that Fred Costner has appeared in.

SELECT title
FROM film
LEFT OUTER JOIN film_actor ON film.film_id=film_actor.film_id
LEFT OUTER JOIN actor ON film_actor.actor_id=actor.actor_id
WHERE first_name = 'Fred '
AND last_name = 'Costner';

--How many distinct countries are there?

SELECT COUNT(country)
FROM country;

--or
SELECT DISTINCT COUNT(country) AS distinct_countries
FROM country;

--List the name of every language in reverse-alphabetical order.

SELECT name FROM language ORDER BY name DESC;

--List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.

SELECT first_name, last_name
FROM actor_info
WHERE last_name LIKE '%son'
ORDER BY first_name ASC;

--Which category contains the most films?

SELECT category.name, COUNT(film_category.category_id)
FROM category
LEFT OUTER JOIN film_category ON category.category_id=film_category.category_id#
GROUP BY film_category.category_id
ORDER BY COUNT(film_category.category_id) ASC LIMIT 1;


