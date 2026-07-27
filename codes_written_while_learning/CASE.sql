SELECT 
job_postings_fact.salary_year_avg,
CASE
WHEN salary_year_avg > 50000 THEN 'high'
WHEN salary_year_avg BETWEEN 10000 AND 50000 THEN 'medium'
ELSE 'low'
END AS buckets
FROM job_postings_fact
WHERE 
job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC NULLS LAST