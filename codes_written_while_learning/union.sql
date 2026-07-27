WITH q1 AS (SELECT *
FROM
jan_jobs
WHERE salary_year_avg > 70000
AND
job_title_short = 'Data Analyst'

UNION

SELECT *
FROM
feb_jobs
WHERE salary_year_avg > 70000
AND
job_title_short = 'Data Analyst'

UNION

SELECT 
*
FROM
mar_jobs
WHERE salary_year_avg > 70000
AND
job_title_short = 'Data Analyst'
)
SELECT 
q1.job_id,
q1.job_title_short,
q1.job_posted_date::DATE,
q1.salary_year_avg,
skills_dim.skills
FROM
q1
LEFT JOIN skills_job_dim ON skills_job_dim.job_id  = q1.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
q1.salary_year_avg DESC