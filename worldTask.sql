--Using COUNT, get the number of cities in the USA.

SELECT COUNT(name)
FROM city
WHERE countryCode = 'USA';

--Find out the population and life expectancy for people in Argentina.

SELECT Population, LifeExpectancy
FROM country
WHERE name = 'Argentina';

--Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?

SELECT name
FROM country
WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC LIMIT 1;

--Using JOIN ... ON, find the capital city of Spain.

SELECT city.name
FROM city
LEFT OUTER JOIN country ON country.capital=city.ID
WHERE country.name = 'Spain';

--Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.

SELECT language
FROM countrylanguage
LEFT OUTER JOIN country ON countrylanguage.countryCode=country.Code
WHERE region = 'Southeast Asia';

--Using a single query, list 25 cities around the world that start with the letter F.

SELECT name FROM city WHERE name LIKE 'F%' LIMIT 25;

--Using COUNT and JOIN ... ON, get the number of cities in China.

SELECT COUNT(*)
FROM city
LEFT OUTER JOIN country AS c ON city.countryCode=c.Code
WHERE c.name = 'China';

--Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.

SELECT name, population 
FROM country
WHERE Population IS NOT NULL 
ORDER BY population ASC LIMIT 1;

--Using aggregate functions, return the number of countries the database contains.

SELECT COUNT(name)
FROM country;

--What are the top ten largest countries by area?

SELECT name
FROM country
ORDER BY SurfaceArea DESC LIMIT 10;

--List the five largest cities by population in Japan.

SELECT name
FROM city
ORDER BY population DESC LIMIT 5;

--List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!

UPDATE country 
SET HeadOfState='Elizabeth II' 
WHERE HeadOfState='Elisabeth II';

SELECT name, Code
FROM country
WHERE headofstate = 'Elizabeth II';

--List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.

SELECT name, population / SurfaceArea
FROM country
ORDER BY population / SurfaceArea DESC LIMIT 10;

--List every unique world language.

SELECT DISTINCT Language 
FROM countrylanguage;

--List the names and GNP of the world's top 10 richest countries.

SELECT name, GNP
FROM country 
ORDER BY GNP DESC LIMIT 10;

--List the names of, and number of languages spoken by, the top ten most multilingual countries.

SELECT country.name, COUNT(C.language)
FROM country
JOIN countrylanguage AS c ON country.code=c.countryCode
GROUP BY country.name
ORDER BY COUNT(C.language) DESC LIMIT 10;

--List every country where over 50% of its population can speak German.

SELECT name
FROM country
JOIN countrylanguage AS c ON country.code=c.countryCode
WHERE language = 'German'
AND percentage > 50;

--Which country has the worst life expectancy? Discard zero or null values.

SELECT name
FROM country
WHERE LifeExpectancy IS NOT NULL
AND LifeExpectancy > 0
ORDER BY LifeExpectancy ASC LIMIT 1;