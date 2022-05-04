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
