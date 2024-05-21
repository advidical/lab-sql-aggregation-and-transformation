use sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT
	max(length) as 'max_duration',
	min(length) as 'min_duration'
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT CONCAT(FLOOR(avg(length) / 60), ' Hour(s) ', FLOOR(avg(length) % 60), ' Minute(s)') AS 'Average Movie Duration'
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
-- use the rental table, use DATEDIFF() to subtract earliest date in the rental_date column from the latest date. 

select datediff(max(rental_date), min(rental_date)) as Days_in_operation from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 3. Retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.

-- Please note that even if there are currently no null values in the rental duration column, 
-- the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT IFNULL(title, 'Not Available') AS 'Title',
IFNULL(rental_duration, 'Not Available') AS 'Rental Duration'
FROM film
ORDER BY title ASC;
-- 4 Bonus : retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you 
-- can address them by their first name and use their email address to send 
-- personalized recommendations. The results should be ordered by last name 
-- in ascending order to make it easier to use the data.

SELECT CONCAT(first_name, ' ', last_name) as 'Customer Name', 
	   SUBSTRING(email, 1, 3) as email_portion 
FROM customer 
ORDER BY last_name ASC;

-- =========================================================================================================
-- Challenge 2
-- 1 Next, you need to analyze the films in the collection to gain some more insights.
-- Using the film table, determine: 

-- 1.1 The total number of films that have been released.

select count(*) as 'Total Released Films' from film;

-- 1.2 The number of films for each rating.

SELECT rating, COUNT(title) AS 'Number of Films per Rating'
FROM film
Group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT rating,
	   COUNT(title) AS 'Number of Films per Rating'
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating,
	   round(avg(length), 2) AS Average_Duration
FROM film
GROUP BY rating
ORDER BY Average_Duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating
FROM film
GROUP BY rating
Having AVG(length) > 120;

-- Bonus: determine which last names are not repeated in the table actor. 
SELECT last_name
from actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;