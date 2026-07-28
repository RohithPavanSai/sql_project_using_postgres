SELECT
skills_job_dim.skill_id,
skills_dim.skills,
AVG(job_postings_fact.salary_year_avg) as salary_avg
FROM
skills_job_dim
INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
skills_job_dim.skill_id,
Skills_dim.skills
ORDER BY
salary_avg DESC NULLS LAST
LIMIT
1000

/*simple query to get average of salaries and sorting skills
as per highest salary */