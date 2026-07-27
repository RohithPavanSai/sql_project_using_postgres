SELECT DISTINCT
company_dim.name,
job_postings_fact.job_posted_date
FROM
company_dim
INNER JOIN job_postings_fact ON job_postings_fact.company_id = company_dim.company_id
WHERE job_postings_fact.job_health_insurance = TRUE AND 
--(EXTRACT(YEAR FROM job_postings_fact.job_posted_date) = 2023 AND ( EXTRACT(MONTH FROM job_postings_fact.job_posted_date) BETWEEN 4 AND 6))
--actual dhi
EXTRACT (QUARTER FROM job_postings_fact.job_posted_date ) = 2