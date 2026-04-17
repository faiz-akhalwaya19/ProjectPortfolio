-- Portfolio Project 1
-- BASIC QUERIES

SELECT *
FROM car_sales_data;

SELECT DISTINCT Manufacturer
FROM car_sales_data;

SELECT DISTINCT Model, Manufacturer
FROM car_sales_data
ORDER BY Manufacturer;

SELECT *
FROM car_sales_data
ORDER BY Price;

SELECT *
FROM car_sales_data
WHERE Manufacturer IS NULL
	OR Model IS NULL
    OR `Fuel type` IS NULL;




-- SECONDARY TABLE

CREATE TABLE car_data
LIKE car_sales_data;

SELECT *
FROM car_data;

INSERT INTO car_data
SELECT *
FROM car_sales_data;

SELECT *
FROM car_data;

SELECT DISTINCT *
FROM car_data;

SELECT *
FROM car_data
ORDER BY Price;


SELECT *
FROM car_data
WHERE Manufacturer = 'VW'
AND Model = 'Polo'
AND `Engine size` = 1.2
ORDER BY Mileage;




-- REOVING DUPLICATES

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Manufacturer, Model, `Engine size`, `Fuel type`,
	`Year of Manufacture`, Mileage, Price) AS row_num
    FROM car_data
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT 
    Manufacturer, Model, `Year of Manufacture`, Mileage, Price,
    COUNT(*) AS duplicate_count
FROM car_data
GROUP BY Manufacturer, Model, `Engine size`, `Fuel type`,
         `Year of Manufacture`, Mileage, Price
HAVING COUNT(*) > 1;

WITH duplicate_cte AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY Manufacturer, Model, `Engine size`, `Fuel type`,
                         `Year of Manufacture`, Mileage, Price
            ORDER BY Manufacturer
        ) AS row_num
    FROM car_data
)

DELETE FROM car_data
WHERE (Manufacturer, Model, `Engine size`, `Fuel type`,
       `Year of Manufacture`, Mileage, Price) IN (
    SELECT * FROM (
        SELECT Manufacturer, Model, `Engine size`, `Fuel type`,
               `Year of Manufacture`, Mileage, Price
        FROM duplicate_cte
        WHERE row_num > 1
    ) AS temp
);

SELECT 
    Manufacturer, Model, `Engine size`, `Fuel type`,
    `Year of Manufacture`, Mileage, Price,
    COUNT(*) 
FROM car_data
GROUP BY Manufacturer, Model, `Engine size`, `Fuel type`,
         `Year of Manufacture`, Mileage, Price
HAVING COUNT(*) > 1;





-- STANDARDISING DATA

SELECT *
FROM car_data;

SELECT Manufacturer, TRIM(Manufacturer)
FROM car_data;

UPDATE car_data
SET Manufacturer = TRIM(Manufacturer);

SELECT *
FROM car_data
WHERE price <= 0
   OR mileage < 0
   OR `Year of Manufacture` < 1980;
   






