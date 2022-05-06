--List the titles and release dates of movies released between 1983-1993 in reverse chronological order.

SELECT title, release_date
FROM movies
WHERE release_date BETWEEN '1983-01-01' AND '1993-01-01'
ORDER BY release_date DESC;

--Without using LIMIT, list the titles of the movies with the lowest average rating.

SELECT movies.id, title
FROM movies
JOIN genres_movies ON genres_movies.movie_id=movies.id
JOIN genres ON genres.id=genres_movies.genre_id
JOIN ratings ON ratings.movie_id=movies.id
JOIN users ON users.id=ratings.user_id
JOIN occupations ON occupations.id=users.occupation_id
WHERE genres.name='Sci-Fi'
AND users.age='24'
AND users.gender='m'
AND ratings.rating='5'
AND occupations.name='Student';

--List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.

SELECT title, AVG(rating) AS average_rating
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
GROUP BY movies.title
HAVING average_rating = (
	SELECT MIN(avg_rating)
	FROM (
		SELECT AVG(rating) AS avg_rating
		FROM ratings
		GROUP BY movie_id
	) AS table1
)
ORDER BY average_rating;

--or
SELECT title, AVG(ratings.rating) 
FROM movies 
JOIN ratings ON movies.id = ratings.movie_id 
GROUP BY title 
HAVING AVG(ratings.rating) = (SELECT MIN(rating) FROM ratings);

--List the unique titles of each of the movies released on the most popular release day.

SELECT title
FROM movies
WHERE release_date=(
	SELECT release_date
	FROM movies
	GROUP BY release_date
	ORDER BY COUNT(id) DESC
	LIMIT 1
);

--Find the total number of movies in each genre; list the results in ascending numeric order.

SELECT genre_id, COUNT(movie_id)
FROM genres_movies
GROUP BY genre_id
ORDER BY COUNT(movie_id) ASC;