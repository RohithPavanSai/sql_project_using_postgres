SELECT 
EXTRACT(MONTH from job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') as MONTHS,
COUNT(job_id)
FROM
job_postings_fact
WHERE 
EXTRACT(year from job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = '2023'
GROUP BY
MONTHS
ORDER BY 
months

/*Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in 'America/New_York' time zone before extracting the month. Assume the job_posted_date is stored in UTC. Group by and order by the month.



I can write inside extractv to change time zones*/