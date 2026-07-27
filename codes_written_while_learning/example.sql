(UPDATE job_applied
SET test = 'succesful1'
WHERE job_id = 1;

UPDATE job_applied
SET test = 'succesful2'
WHERE job_id = 2;

ALTER TABLE job_applied
RENAME COLUMN test TO testing)


