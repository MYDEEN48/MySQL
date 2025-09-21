-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;
USE sql_project_p2;
select * from  `sql - retail sales analysis_utf  (2)`;

-- Create TABLE
DROP TABLE IF EXISTS  retail_sales
CREATE TABLE  retail_ sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10;


    

SELECT 
    COUNT(*) 
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;



SELECT DISTINCT category FROM retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from  `sql - retail sales analysis_utf  (2)`
where sale_date ='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from  `sql - retail sales analysis_utf  (2)`
where category = 'Clothing' 
      and sale_date between '2022-11-01' and '2022-11-30' 
      and quantiy>2;
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,
round(sum(total_sale))as totalprofit
from `sql - retail sales analysis_utf  (2)`
group by category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
avg(age)as average_age
from  `sql - retail sales analysis_utf  (2)`
where category='beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
avg(age)as average_age
from  `sql - retail sales analysis_utf  (2)`
where category='beauty';
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each categor
select category,gender,
count(distinct(transaction_id))as transaction_id
from  `sql - retail sales analysis_utf  (2)`
group by category, gender;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
year(sale_date) AS year,
month(sale_date) AS month,
avg(total_sale * price_per_unit) AS average_sale_month
from
  `sql - retail sales analysis_utf  (2)`
 group by 
 (sale_date),
month(sale_date) 
 order by
 year , month;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,
round(sum(quantiy*price_per_unit),0)as total
from  `sql - retail sales analysis_utf  (2)`
group by customer_id
order by total desc
limit 5; 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count(distinct(customer_id))as customers
from  `sql - retail sales analysis_utf  (2)`
group by category;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
-- Step 1: Create the table
CREATE TABLE employee_sales (
    emp_id INT,
    emp_name VARCHAR(50),
    sales_date DATE,
    sales_amount INT
);

-- Step 2: Insert sample data
INSERT INTO employee_sales (emp_id, emp_name, sales_date, sales_amount) VALUES
(1, 'Alice', '2025-08-01', 1000),
(2, 'Alice', '2025-08-02', 1200),
(3, 'Alice', '2025-08-03', 1100),
(4, 'Bob',   '2025-08-01', 900),
(5, 'Bob',   '2025-08-02', 950),
(6, 'Bob',   '2025-08-03', 1000);

-- Step 3: Query using LAG and LEAD
SELECT 
    emp_name,
    sales_date,
    sales_amount,
    LAG(sales_amount) OVER (
        PARTITION BY emp_name 
        ORDER BY sales_date
    ) AS previous_day_sales,
    LEAD(sales_amount) OVER (
        PARTITION BY emp_name 
        ORDER BY sales_date
    ) AS next_day_sales
FROM 
    employee_sales;




