/* getting companiees which give most no of jobs*/

SELECT
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google,
COUNT(*) AS no_of_jobs_per_company
FROM
job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
GROUP BY
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google
ORDER BY
no_of_jobs_per_company DESC NULLS LAST