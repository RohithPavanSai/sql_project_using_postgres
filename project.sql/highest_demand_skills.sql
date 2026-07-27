SELECT 
skills_job_dim.skill_id,
skills_dim.skills,
COUNT(*) as no_of_jobs_per_skill
FROM
skills_job_dim
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
skills_job_dim.skill_id,
skills_dim.skills
ORDER BY no_of_jobs_per_skill DESC NULLS LAST
LIMIT 100