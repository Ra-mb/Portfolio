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

-- 1. Write a SQL query to retrieve sales person who make the highest revenue
SELECT
    sales_name,
    SUM(amount) AS penjualan
FROM cho_sales2
GROUP BY sales_name
ORDER BY penjualan DESC;

-- 2. Write a SQL query to retrieve total sales in each country
SELECT
    country,
    EXTRACT(MONTH FROM sale_date) as month,
    SUM(amount)
FROM cho_sales2
GROUP BY country;

-- 3. Write a SQL query to retrieve best-selling product
SELECT
    product,
    SUM(amount) as product_sales_sum
FROM cho_sales2
GROUP BY product
ORDER BY product_sales_sum DESC;

-- 4. Write a SQL query to calculate the average sale for each month. Find out best selling month
SELECT 
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(amount) as avg_sale
FROM cho_sales2
GROUP BY month
ORDER BY avg_sale DESC
LIMIT 1;