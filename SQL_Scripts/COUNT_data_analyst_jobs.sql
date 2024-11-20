/*
You can use "/* and */" to comment out a group of text.
*/

-- You can only use the WHERE query once.

-- Q1 What is the count of the dataset?

SELECT *
FROM data_analyst_jobs
WHERE skill = 'SQL';

SELECT company, skill, star_rating, days_since_posting
FROM data_analyst_jobs
WHERE star_rating > 4
ORDER BY star_rating DESC,
	days_since_posting DESC;
	





