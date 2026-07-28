/* getting companiees which give highest salary */

SELECT
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google,
AVG(salary_year_avg) AS avg_sal_per_company
FROM
job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
GROUP BY
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google
ORDER BY
avg_sal_per_company DESC NULLS LAST