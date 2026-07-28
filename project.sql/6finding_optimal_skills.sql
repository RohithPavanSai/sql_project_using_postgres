WITH demand as (WITH before_normalisation AS (SELECT 
skills_job_dim.skill_id,
skills_dim.skills,
COUNT(*) as no_of_jobs_per_skill
FROM
skills_job_dim
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
skills_job_dim.skill_id,
skills_dim.skills
),


ready_to_normalise as (SELECT
    skill_id,
    skills,
    no_of_jobs_per_skill,
    MIN(no_of_jobs_per_skill) OVER() as minn,
    MAX(no_of_jobs_per_skill) OVER() as maxx
    FROM 
    before_normalisation)

SELECT 
skill_id,
    skills,
(no_of_jobs_per_skill - minn)*1.0/(maxx-minn) as norm_value_for_demand
FROM
ready_to_normalise),

high_salary as (

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
Skills_dim.skills),

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
)

SELECT 
demand.skill_id,
demand.skills,
(demand.norm_value_for_demand + high_salary.norm_value_for_salary)/2 as score
FROM
demand
INNER JOIN high_salary ON demand.skill_id = high_salary.skill_id
ORDER BY 
score DESC NULLS LAST