/* just like previous file I did normalization*/


WITH before_normalisation AS (SELECT
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
salary_avg DESC NULLS LAST),

ready_to_normalise as (SELECT
    skill_id,
    skills,
    salary_avg,
    MIN(salary_avg) OVER() as minn,
    MAX(salary_avg) OVER() as maxx
    FROM 
    before_normalisation)
SELECT 
skill_id,
    skills,
(salary_avg - minn)*1.0/(maxx-minn) as norm_value_for_salary
FROM
ready_to_normalise