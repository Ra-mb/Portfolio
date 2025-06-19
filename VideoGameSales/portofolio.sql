SELECT *
FROM game;

SELECT Global_Sales
FROM game;

SELECT DISTINCT Genre
FROM game
ORDER BY Genre;

SELECT 
	Genre,
    Platform,
	ROUND(MAX(Global_Sales),2) AS max_sales,
    ROUND(MIN(Global_Sales),2) AS min_sales,
    ROUND(AVG(Global_Sales),2) AS average_sales,
    ROUND(SUM(Global_Sales),2) AS total_sales
FROM game
GROUP BY Genre, Platform;

-- 1. Analysis of total global sales per year.
SELECT 
	Year, 
	ROUND(SUM(Global_Sales),2) as total_sales
FROM game
GROUP BY Year
ORDER BY total_sales DESC;

-- 2. Platform Popularity Analysis
SELECT 
	Platform, 
    ROUND(SUM(Global_Sales),2) as total_sales
FROM game
GROUP BY Platform
ORDER BY total_sales DESC;

-- 3. Analysis of the Most Profitable Genres
SELECT 
	Genre, 
    ROUND(SUM(Global_Sales),2) as total_sales
FROM game
GROUP BY Genre
ORDER BY total_sales DESC;

-- 4. Analysis of the Most Profitable Genres in Some Countries
SELECT 
	Genre, 
    ROUND(SUM(north_america_sales),2) as north_america_region,
    ROUND(SUM(europe_sales),2) as europe_region,
    ROUND(SUM(japan_sales),2) as japan_region,
    ROUND(SUM(Other_Sales),2) as other_region,
    ROUND(SUM(Global_Sales),2) as total_sales
FROM game
GROUP BY Genre
ORDER BY total_sales DESC;

-- 5. Analysis of the Most Profitbale Genres in Japan
SELECT 
	Genre,
	ROUND(SUM(japan_sales),2) as japan_sales
FROM game
GROUP BY Genre
ORDER BY japan_sales DESC;
