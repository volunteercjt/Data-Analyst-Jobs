-- The dataset for this exercise has been derived from the `Indeed Data Scientist/Analyst/Engineer` [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer) on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

--1.	How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs

--Answer:  1793

--2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--Answer:  ExxonMobil

--3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT *
FROM data_analyst_jobs
WHERE location ILIKE 'TN' OR location ILIKE 'KY'

--Postings in TN:  21

--Posting in TN or KY:  27


--4.	How many postings in Tennessee have a star rating above 4?

SELECT *
FROM data_analyst_jobs
WHERE star_rating > 4

--Answer:  416

--5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT *
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000

--Answer:  151

--6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY state
ORDER BY avg_rating DESC

--Answer:  NE has highest average rating.

--7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT DISTINCT(title)
FROM data_analyst_jobs

-- Answer:  881

--8.	How many unique job titles are there for California companies?

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE location ILIKE '%CA%'

-- Answer:  230

--9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count > 5000
AND company IS NOT NULL
GROUP BY company

-- Answer:  40 companies have > 5000

--10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count > 5000
AND company IS NOT NULL
GROUP BY company
ORDER BY avg_star_rating DESC

Answer:  It is a 6 way tie between American Express, General Motors, Kaiser Permanente, Microsoft, Nike, and Unilever.  Rating: 4.2

11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE UPPER(title) LIKE '%ANALYST%'


12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%'

**BONUS:**
You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
 - Disregard any postings where the domain is NULL. 
 - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
  - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT domain, COUNT(domain)
FROM data_analyst_jobs
WHERE days_since_posting > 21
AND skill ILIKE '%SQL%'
AND domain IS NOT NULL
AND review_count IS NOT NULL
GROUP BY domain
ORDER BY count DESC

SELECT domain, COUNT(domain) AS count_days_since_posting
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%'
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY count_days_since_posting DESC