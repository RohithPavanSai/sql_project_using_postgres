SELECT 
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
ORDER BY no_of_jobs_per_skill DESC NULLS LAST
LIMIT 100

/* this is a simple code to get most demanded skills for
data analyst roles,
I used right join it's not necessary I will remove it if I use this code again in findind best skill
but it shows an important observation
there are 36801 jobs listed for data analyst with skills
not mentioned in skills_job_dim right join made me found that */

/*update : I am changin it to inner join because I am finding most 
demanded skills not interesting observations */