WITH demand AS (WITH before_normalisation AS (SELECT
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google,
COUNT(*) AS no_of_jobs_per_company
FROM
job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
GROUP BY
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google
),


ready_to_normalise as (SELECT
   company_id,
   name,
   link,
   link_google,
   no_of_jobs_per_company,
    MIN(no_of_jobs_per_company) OVER() as minn,
    MAX(no_of_jobs_per_company) OVER() as maxx
    FROM 
    before_normalisation)

SELECT 
company_id,
   name,
   link,
   link_google,
(no_of_jobs_per_company - minn)*1.0/(maxx-minn) as norm_value_for_demand
FROM
ready_to_normalise),

high_salary as(

   WITH before_normalisation AS (SELECT
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google,
AVG(salary_year_avg) AS avg_sal_per_company
FROM
job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
AND 
salary_year_avg IS NOT NULL
GROUP BY
company_dim.company_id,
company_dim.name,
company_dim.link,
company_dim.link_google
),


ready_to_normalise as (SELECT
   company_id,
   name,
   link,
   link_google,
   avg_sal_per_company,
    MIN(avg_sal_per_company) OVER() as minn,
    MAX(avg_sal_per_company) OVER() as maxx
    FROM 
    before_normalisation)

SELECT 
company_id,
   name,
   link,
   link_google,
(avg_sal_per_company - minn)*1.0/(maxx-minn) as norm_value_for_salary
FROM
ready_to_normalise 
)

SELECT 
demand.company_id,
demand.name,
demand.link,
demand.link_google,
(demand.norm_value_for_demand + high_salary.norm_value_for_salary)/2 as score
FROM
demand
INNER JOIN high_salary ON demand.company_id= high_salary.company_id
ORDER BY 
score DESC NULLS LAST

/* I used the same exact normalisation techinque which I used before,
looking at results, 
Robert Half , Mantys, Citi , Insight Global and Dice are best companies
to target for a Data Analyst role*/