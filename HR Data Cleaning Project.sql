-- Cleaning the HR Data

CREATE DATABASE hr_project;

USE hr_project;

SELECT *
FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%'
    THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%'
    THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE null
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT birthdate 
FROM hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%'
    THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%'
    THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE null
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date
FROM hr;

SELECT termdate
FROM hr;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
ADD COLUMN age INT;

describe hr;

SELECT *
FROM hr;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM hr;

SELECT COUNT(*) 
FROM hr
WHERE age < 18;