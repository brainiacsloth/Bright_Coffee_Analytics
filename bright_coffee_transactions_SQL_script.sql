/*
Vümboni Msimango
SSMS Data Analytics
20 August 2025

I imported my CSV file into SSMS. 
I checked to ensure that all my data was in the right format,
I then proceeded to carry out my analysis. 
*/


---Preliminary data inspection
SELECT TOP 5 *
FROM [dbo].[BrightCoffeeTransactions]

---Most profitable product category
SELECT 
    TOP 5
    product_category,
    SUM(unit_price * transaction_qty) AS total_profit
FROM [dbo].[BrightCoffeeTransactions]
GROUP BY product_category
ORDER BY total_profit DESC;

---EDA to determine what the most profitabe product type is within the broader coffee category.
SELECT 
    product_category,
    product_type,
    SUM(unit_price * transaction_qty) AS total_profit
FROM [dbo].[BrightCoffeeTransactions]
WHERE product_category = 'Coffee'
GROUP BY product_category, product_type
ORDER BY total_profit DESC;

---EDA to determine the most profitable product by location.
SELECT 
    store_location,
    product_category,
    SUM(unit_price * transaction_qty) AS total_profit
FROM [dbo].[BrightCoffeeTransactions]
GROUP BY store_location, product_category
ORDER BY store_location ASC, total_profit DESC;

---This script specifically extracts the day of the week and classifies it as a Weekday or Weekend and it creates time buckets. 
SELECT
    transaction_date AS purchase_date,
    DAY(transaction_date) AS day_of_month,
    DATENAME(MONTH, transaction_date) AS name_of_month,
    FORMAT(transaction_date, 'yyyy-MM') AS month_id,
    DATENAME(WEEKDAY, transaction_date) AS day_name,
    CASE
        WHEN DATENAME(WEEKDAY, transaction_date) NOT IN ('Saturday', 'Sunday') THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_classification,
    transaction_time,
        CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '08:59:59' THEN 'Early Morning'
        WHEN transaction_time BETWEEN '09:00:00' AND '11:59:59' THEN 'Morning'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,

    --- Similarly, I employ the CASE statement to generate my time range buckets.
    CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '08:59:59' THEN '6am-9am'
        WHEN transaction_time BETWEEN '09:00:00' AND '11:59:59' THEN '9am-12pm'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '12pm-4pm'
        WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '4pm-8pm'
        ELSE '8pm+'
    END AS time_range
FROM dbo.BrightCoffeeTransactions;

/* I intend to save a view so I can use it in Power BI, so I load all my columns and the 
date and time buckets - everything above into this on */

CREATE VIEW complete_transactions_BrightCoffee AS
SELECT
    transaction_id,
    transaction_date AS purchase_date,
    DAY(transaction_date) AS day_of_month,
    DATENAME(MONTH, transaction_date) AS name_of_month,
    FORMAT(transaction_date, 'yyyy-MM') AS month_id,
    DATENAME(WEEKDAY, transaction_date) AS day_name,
    CASE
        WHEN DATENAME(WEEKDAY, transaction_date) NOT IN ('Saturday', 'Sunday') THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_classification,
    transaction_time,
        CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '08:59:59' THEN 'Early Morning'
        WHEN transaction_time BETWEEN '09:00:00' AND '11:59:59' THEN 'Morning'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,
 
    CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '08:59:59' THEN '6am-9am'
        WHEN transaction_time BETWEEN '09:00:00' AND '11:59:59' THEN '9am-12pm'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '12pm-4pm'
        WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '4pm-8pm'
        ELSE '8pm+'
    END AS time_range,

    transaction_qty,
    store_id,
    store_location,
    product_id,
    unit_price,
    product_category,
    product_type,
    product_detail
FROM dbo.BrightCoffeeTransactions;
