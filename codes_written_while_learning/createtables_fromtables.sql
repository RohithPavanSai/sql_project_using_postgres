CREATE TABLE mar_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_postings_fact.job_posted_date) = 3