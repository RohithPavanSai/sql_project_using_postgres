SELECT 
job_postings_fact.job_schedule_type,
AVG(salary_year_avg) as yearly,
AVG(salary_hour_avg) as hourly
FROM
job_postings_fact
WHERE
job_posted_date >= '2023-06-01'
GROUP BY
job_schedule_type