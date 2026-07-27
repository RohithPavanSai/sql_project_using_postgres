select 
COUNT(job_id),
job_title,
EXTRACT(MONTH FROM job_posted_date) as MONTHS
from
job_postings_fact
WHERE job_title='Data Analyst'
GROUP BY(MONTHS,job_title)
LIMIT 1000