WITH temp AS(SELECT
company_dim.name as comp_name,
job_postings_fact.company_id,
COUNT(*) AS no_of_postings
FROM job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
GROUP BY job_postings_fact.company_id,
company_dim.name)
SELECT 
comp_name,
company_id,
no_of_postings,
CASE
WHEN no_of_postings <= 10 THEN 'SMALL'
WHEN no_of_postings BETWEEN 11 AND 50 THEN 'MEDIUM'
ELSE 'LARGE'
END AS size_of_comp
FROM
temp