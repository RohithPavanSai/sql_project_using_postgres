 WITH TEMP AS (
    SELECT 
    skills_job_dim.skill_id,
    COUNT(*) AS no_of_jobs
    FROM
    skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_postings_fact.job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id
    ORDER BY no_of_jobs DESC NULLS LAST
    LIMIT 5
)
SELECT 
skills_dim.skills,
TEMP.skill_id,
TEMP.no_of_jobs
FROM skills_dim
INNER JOIN TEMP ON skills_dim.skill_id = TEMP.skill_id
ORDER BY 
no_of_jobs DESC