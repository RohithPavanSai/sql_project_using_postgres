SELECT DISTINCT
company_dim.name AS comp_name
FROM company_dim
WHERE company_id IN
(SELECT
job_postings_fact.company_id
FROM
job_postings_fact
WHERE
job_postings_fact.job_no_degree_mention
)