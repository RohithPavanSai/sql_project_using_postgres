/* since I am trying to find best skills
based on demand(no_of_postings) and based on highest salary, so the plan is to
average the both giving 50% importance to each,
but just averaging is not optimal and not meaningful so
I am using min max normalisation*/



WITH before_normalisation AS (SELECT 
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
ORDER BY no_of_jobs_per_skill DESC NULLS LAST),


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
ready_to_normalise

