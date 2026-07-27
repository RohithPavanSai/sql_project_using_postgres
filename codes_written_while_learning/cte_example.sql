WITH CTC AS(SELECT
company_id,
COUNT(*) as no_of
FROM job_postings_fact
GROUP BY company_id
)

SELECT
company_dim.name as comp_name,
CTC.company_id,
CTC.no_of
FROM company_dim
LEFT JOIN CTC ON company_dim.company_id = CTC.company_id
ORDER BY no_of DESC