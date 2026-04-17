-- EXPLORATORY DATA ANALYSIS


SELECT *
FROM car_data;

SELECT Manufacturer, Model, `Engine size`, `Year of manufacture`, Price
FROM car_data;

SELECT Manufacturer, AVG(Price) AS Avg_Price
FROM car_data
GROUP BY Manufacturer
ORDER BY Avg_Price DESC;

SELECT Price, Mileage, Manufacturer, Model, `Year of manufacture`
FROM car_data
ORDER BY Price;

SELECT Mileage, Price, Manufacturer, Model, `Year of manufacture`
FROM car_data
ORDER BY Mileage;

SELECT DISTINCT Model, Manufacturer, `Engine size`
FROM car_sales_data
ORDER BY `Engine size`;

SELECT `Engine size`, COUNT(`Engine size`) AS Num_Engines
FROM car_sales_data
GROUP BY `Engine size`
ORDER BY `Engine size`;

SELECT `Fuel type`, COUNT(`Fuel type`) AS Num_Fuel_type
FROM car_sales_data
GROUP BY `Fuel type`;

SELECT `Fuel type`, AVG(Price) AS Avg_Price
FROM car_data
GROUP BY `Fuel type`;

SELECT `Year of manufacture`, COUNT(*) AS Total_cars
FROM car_data
GROUP BY `Year of manufacture`
ORDER BY `Year of manufacture`;

SELECT Manufacturer, Model, Price
FROM car_data
ORDER BY Price DESC
LIMIT 5;

SELECT 
	CASE
		WHEN Mileage < 50000 THEN 'Low Mileage'
        WHEN Mileage BETWEEN 50000 AND 150000 THEN 'Medium Mileage'
        ELSE 'High Mileage'
	END AS `Mileage Category`,
    AVG(Price) AS Avg_Price
FROM car_data
GROUP BY `Mileage Category`;

SELECT 
	CASE
		WHEN Mileage < 50000 THEN 'Low Mileage'
        WHEN Mileage BETWEEN 50000 AND 150000 THEN 'Medium Mileage'
        ELSE 'High Mileage'
	END AS `Mileage Category`,
    AVG(Price) AS Avg_Price, MAX(Price) AS Max_Price, MIN(Price) AS Min_Price
FROM car_data
GROUP BY `Mileage Category`;

