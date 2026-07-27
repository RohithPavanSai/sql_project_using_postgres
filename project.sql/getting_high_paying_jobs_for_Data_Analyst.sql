/* this is first code, I am just gonna get top 100 jobs 
ordered by their salaries,and gonna mention the location,salary,skills and companies*/

-- BASIC STRUCTURE 

/* bascially there are job listings in one table with skill_id,company_id as foreign keys,
it is known as job_listings_fact table and 
then we have skills_job_dim table which has job_id and skills_id
then we have skills_dim with skill names 
and at last company_dim with company details
this is the structure of this data base, I will include picture and a more detailed explaination in 
README file*/

WITH skills_temp AS(
SELECT
job_postings_fact.job_id,
job_postings_fact.company_id,
job_title_short,
STRING_AGG(distinct skills_dim.skills,',') AS all_skills,
job_location,
job_posted_date::DATE,
salary_year_avg
FROM
job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short LIKE '%Data%Analyst%'
GROUP BY job_postings_fact.job_id
ORDER BY salary_year_avg DESC NULLS LAST
LIMIT 100
)
SELECT
skills_temp.job_id,
job_title_short,
all_skills,
job_location,
job_posted_date::DATE,
salary_year_avg,
company_dim.name as comp_name
FROM
skills_temp
LEFT JOIN company_dim ON skills_temp.company_id = company_dim.company_id
ORDER BY salary_year_avg DESC NULLS LAST

-- Key Takeaways:
/* After Analysing the code thorougly I found:
Main imporvement: currently my code is aggregating skills for all jobs and then taking
top 100, for a much larger database it can be slower, so first get top100 and then
aggregate,

2.The group by section has only job_id and I didnot include other columns, but all of them
are unique and postgres understands it, but most other sql may not allow it, I have to group by
all the columns

 I am keeping the code same though...!!!*/