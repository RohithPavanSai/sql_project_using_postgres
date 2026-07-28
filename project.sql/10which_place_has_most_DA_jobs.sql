/* it's a simple query to know which place or city has more
Data Analyst roles*/
SELECT
job_location,
COUNT(*) AS no_of_jobs,
AVG(salary_year_avg) as salary_average
FROM
job_postings_fact
WHERE
job_title_short = 'Data Analyst'
GROUP BY job_location
ORDER BY
no_of_jobs DESC NULLS LAST

/* so there are many remote jobs */