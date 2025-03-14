# Chocolate Sales Analysis SQL Project

## Project Overview

**Project Title**: Chocolate Sales Analysis  
**Database**: `cho_sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze chocolate sales data. The project involves import database from csv file, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Import chocolate sales database**: Import Chocolate sales database from csv.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Standardizing Data**: Identify and standardize any records to give a better visualization.
4. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
5. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by import a database from `cho_sales.csv`.


### 2. Data Cleaning

- **Create a new database**: Create a new database to do a data transformations, cleaning etc to make sure if any misquery, i don't lose the data.
- **Remove Duplicate**: Remove any duplicate record.
- **Standardize Data**: Ensure the data ready for analysis.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Remove Columns**: Remove column that unused such as row_num. 

```sql
CREATE TABLE `cho_sales2` (
  `sales_name` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `product` varchar(100) DEFAULT NULL,
  `sale_date` text,
  `amount` int DEFAULT NULL,
  `box_shipped` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cho_sales2
SELECT *,
ROW_NUMBER() OVER
(PARTITION BY sales_name, country, product, sale_date, amount, box_shipped) as row_num
FROM cho_sales;

DELETE
FROM cho_sales2
WHERE row_num > 1;

UPDATE cho_sales2
SET sale_date = str_to_date(sale_date, '%d/%m/%Y');

ALTER TABLE cho_sales2
MODIFY COLUMN sale_date DATE;

SELECT DISTINCT country
FROM cho_sales2;

UPDATE cho_sales2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'Australia%';

SELECT *
FROM cho_sales2
WHERE product IS NULL OR product = '' 
   OR sales_name IS NULL OR sales_name = '' 
   OR country IS NULL OR country = '' 
   OR sale_date IS NULL 
   OR amount IS NULL 
   OR box_shipped IS NULL;

DELETE 
FROM cho_sales2
WHERE product = '';

ALTER TABLE cho_sales2
DROP COLUMN row_num;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer questions:

1. **Write a SQL query to retrieve sales person who make the highest revenue**:
```sql
SELECT
    sales_name,
    SUM(amount) AS penjualan
FROM cho_sales2
GROUP BY sales_name
ORDER BY penjualan DESC;
```

2. **Write a SQL query to retrieve total sales in each country**:
```sql
SELECT
    country,
    EXTRACT(MONTH FROM sale_date) as month,
    SUM(amount)
FROM cho_sales2
GROUP BY country;
```

3. **Write a SQL query to retrieve best-selling product**:
```sql
SELECT
    product,
    SUM(amount) as product_sales_sum
FROM cho_sales2
GROUP BY product
ORDER BY product_sales_sum DESC;
```

4. **Write a SQL query to calculate the average sale for each month. Find out best selling month**:
```sql
SELECT 
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(amount) as avg_sale
FROM cho_sales2
GROUP BY month
ORDER BY avg_sale DESC
LIMIT 1;
```

## Findings

- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the most popular chocolate product.
- **Biggest Markets**: Total sales in each Country helping identify which country has the biggest spending to buy chocolate.
- **Sales Trends**: Helping identify and set to more targeted strategies for that specific month.  

## Reports

- **Sales Summary**: A detailed report summarizing total sales per months, sales person performance, biggest markets.
- **Trend Analysis**: Insights into sales trends across different months and countries.
- **Product Insights**: Reports on top selling products.

My social media:

- **Instagram**: [Let's Connect](https://www.instagram.com/inirtp?igsh=MW9xZTU0bTRuaHlxeQ==)
- **LinkedIn**: [Connect with me professionally]((https://www.linkedin.com/in/rahadian-triaji-pramudito-a43949273?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app))

I look forward to connecting with you!
