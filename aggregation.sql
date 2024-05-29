USE sakila; 

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT sec_to_time(AVG(length) * 60) AS duration FROM film; 

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_difference FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,  SUBSTRING_INDEX(rental_date, ' ', 1) AS date, DATE_FORMAT(CONVERT(rental_date, DATE), '%M')AS month, DATE_FORMAT(CONVERT(rental_date, DATE), '%D') AS month  FROM rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT title AS film_title, IFNULL(rental_duration, 'Not Available') As rental_duration from film
ORDER BY title ASC;

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT  count(film_id) FROM film;

-- 1.2 The number of films for each rating.

SELECT COUNT(film_id) AS film_count, rating FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(film_id) AS film_count, rating FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT Round(AVG(Length),2) AS mean_film_duration, rating FROM film
GROUP BY rating;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT sec_to_time(ROUND(AVG(length)*60, 2)) AS mean_film_duration, rating FROM film
GROUP BY rating
HAVING mean_film_duration > '02:00:00';


