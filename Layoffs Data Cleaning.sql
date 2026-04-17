-- DATA CLEANING

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardise the Data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns or Rows

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


SELECT *
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;



-- STANDARDISING DATA

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%' ;

UPDATE layoffs_staging2
SET industry = 'Crypto' 
WHERE industry LIKE 'Crypto%' ;

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; 

SELECT `date`
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2;


-- NULL AND BLANK VALUES

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT  T1.industry, T2.industry
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
	ON T1.company = T2.company
    AND T1.location = T2.location
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

UPDATE layoffs_staging2 T1
JOIN layoffs_staging2 T2
	ON T1.company = T2.company
SET T1.industry =T2.industry
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2;


-- REMOVING COLUMNS & ROWS

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;