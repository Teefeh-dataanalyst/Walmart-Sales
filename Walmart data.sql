SELECT * 
FROM Walmart_store_sales.dbo.features;

SELECT *
FROM Walmart_store_sales.dbo.stores; 

SELECT * 
FROM Walmart_store_sales.dbo.test;

SELECT *
FROM Walmart_store_sales.dbo.train;



-- Data Cleaning
-- Identifying null values in features table
SELECT COUNT(*) AS total_rows,
SUM(CASE WHEN Store IS NULL THEN 1 ELSE 0 END) AS store_nulls,
SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_nulls,
SUM(CASE WHEN Temperature IS NULL THEN 1 ELSE 0 END) AS temp_nulls,
SUM(CASE WHEN Fuel_Price IS NULL THEN 1 ELSE 0 END) AS Fuel_nulls,
SUM(CASE WHEN MarkDown1 IS NULL THEN 1 ELSE 0 END) AS mark1_nulls,
SUM(CASE WHEN MarkDown2 IS NULL THEN 1 ELSE 0 END) AS mark2_nulls,
SUM(CASE WHEN MarkDown3 IS NULL THEN 1 ELSE 0 END) AS mark3_nulls,
SUM(CASE WHEN MarkDown4 IS NULL THEN 1 ELSE 0 END) AS mark4_nulls,
SUM(CASE WHEN MarkDown5 IS NULL THEN 1 ELSE 0 END) AS mark5_nulls,
SUM(CASE WHEN CPI IS NULL THEN 1 ELSE 0 END) AS CPI_nulls,
SUM(CASE WHEN Unemployment IS NULL THEN 1 ELSE 0 END) AS unemployment_nulls,
SUM(CASE WHEN IsHoliday IS NULL THEN 1 ELSE 0 END) AS holiday_nulls
FROM Walmart_store_sales.dbo.features;

-- Updating null values
UPDATE Walmart_store_sales.dbo.features
SET Temperature = (SELECT AVG(Temperature)
FROM Walmart_store_sales.dbo.features
WHERE Temperature IS NOT NULL)
WHERE Temperature IS NULL;

UPDATE Walmart_store_sales.dbo.features
SET Fuel_Price = (SELECT AVG(Fuel_Price)
FROM Walmart_store_sales.dbo.features
WHERE Fuel_Price IS NOT NULL)
WHERE Fuel_Price IS NULL;

UPDATE Walmart_store_sales.dbo.features
SET CPI = (SELECT AVG(CPI)
FROM Walmart_store_sales.dbo.features
WHERE CPI IS NOT NULL)
WHERE CPI IS NULL;

UPDATE Walmart_store_sales.dbo.features
SET Unemployment = (SELECT AVG(Unemployment)
FROM Walmart_store_sales.dbo.features
WHERE Unemployment IS NOT NULL)
WHERE Unemployment IS NULL;

-- Null values in Train table
select 
count(*) AS total_rows,
SUM(CASE WHEN Store IS NULL THEN 1 ELSE 0 END) AS Store_nulls,
SUM(CASE WHEN Dept IS NULL THEN 1 ELSE 0 END) AS dept_nulls,
SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_nulls,
SUM(CASE WHEN Weekly_Sales IS NULL THEN 1 ELSE 0 END) AS Weeklysales_nulls,
SUM(CASE WHEN IsHoliday IS NULL THEN 1 ELSE 0 END) AS holiday_nulls
from Walmart_store_sales.dbo.train;

-- Updating null values in Train table
UPDATE Walmart_store_sales.dbo.train
SET Weekly_Sales = (SELECT AVG(Weekly_Sales)
FROM Walmart_store_sales.dbo.train WHERE Weekly_Sales is not null)
WHERE Weekly_Sales is null;



-- CASE STUDY
-- What are the trends in weekly sales overtime for each stores and department?

SELECT store, dept, date, SUM(weekly_sales) AS total_weekly_sales
FROM Walmart_Store_Sales.dbo.train
group by store, dept, date
order by store,dept, date;

-- Comparing sales across stores for a single dept
SELECT store, date, sum(weekly_sales) AS total_weekly_sales
FROM Walmart_Store_Sales.dbo.train
WHERE dept = 1
GROUP BY store, date
ORDER BY store, date;

-- Identifying best performing store-department combinations
SELECT store, dept, AVG(weekly_sales) AS avg_weekly_sales
FROM Walmart_Store_Sales.dbo.train
group by store, dept
order by avg_weekly_sales DESC;

-- Seasonal sales pattern(monthly)
SELECT store, dept, DATEPART(month, date) AS Sales_month, AVG(weekly_sales) AS Avg_monthly_sales
FROM Walmart_Store_Sales.dbo.train
GROUP BY store, dept, DATEPART(month, date)
ORDER BY store, dept, sales_month;

-- Month and year with highest and lowest sales
select year(Date) as sales_year, month(Date) as sales_month, sum(Weekly_Sales) as total_sales
from Walmart_Store_Sales.dbo.train
group by year(Date), month(Date)
order by total_sales desc;

-- How do sales vary across different stores?
select Store,  sum(Weekly_Sales) as total_sales, avg(Weekly_Sales) as avg_sales
from Walmart_Store_Sales.dbo.train
group by Store
order by total_sales desc;

-- Impact of Holidays on sales
select IsHoliday, sum(Weekly_Sales) as total_sales, avg(Weekly_Sales) as avg_sales
from Walmart_Store_Sales.dbo.train
group by IsHoliday
order by total_sales desc;

-- Store with the most revenue
select Store, sum(Weekly_Sales) as total_sales
from Walmart_Store_Sales.dbo.train
group by Store
order by total_sales desc;

-- Impact of store size and type 
select s.Store, s.Type, s.Size, sum(Weekly_Sales) as total_sales, avg(Weekly_Sales) as avg_sales
from Walmart_Store_Sales.dbo.train t
join Walmart_Store_Sales.dbo.stores s 
on s.Store = t.Store
group by s.Store, s.Type, s.Size
order by total_sales desc;

-- Department with highest sales
select Dept, sum(Weekly_Sales) as total_sales
from Walmart_Store_Sales.dbo.train 
group by Dept
order by total_sales DESC;

-- Influence of fuel prices, cpi, unemployment on sales
select f.Fuel_Price, f.CPI, f.Unemployment, sum(Weekly_Sales) as total_sales
from Walmart_Store_Sales.dbo.train t
join Walmart_Store_Sales.dbo.features f
on t.Store = f.Store and t.Date = f.Date
group by f.Fuel_Price, f.CPI, f.Unemployment
order by total_sales desc;


-- Markdowns effect on sales

SELECT * 
FROM Walmart_Store_Sales.dbo.features
WHERE MarkDown1 like '%[^0-9.]%'
or MarkDown2 like '%[^0-9.]%'
or MarkDown3 like '%[^0-9.]%'
or MarkDown4 like '%[^0-9.]%'
or MarkDown5 like '%[^0-9.]%';

update Walmart_Store_Sales.dbo.features
set MarkDown1 = '0' where MarkDown1 like '%[^0-9.]%';
update Walmart_Store_Sales.dbo.features
set MarkDown2 = '0' where MarkDown2 like '%[^0-9.]%';
update Walmart_Store_Sales.dbo.features
set MarkDown3 = '0' where MarkDown3 like '%[^0-9.]%';
update Walmart_Store_Sales.dbo.features
set MarkDown4 = '0' where MarkDown4 like '%[^0-9.]%';
update Walmart_Store_Sales.dbo.features
set MarkDown5 = '0' where MarkDown5 like '%[^0-9.]%';



alter table Walmart_Store_Sales.dbo.features
alter column MarkDown1 FLOAT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown2 FLOAT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown3 FLOAT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown4 FLOAT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown5 FLOAT;
















alter table Walmart_Store_Sales.dbo.features
alter column MarkDown1 INT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown2 INT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown3 INT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown4 INT;
alter table Walmart_Store_Sales.dbo.features
alter column MarkDown5 INT;



select 
case when MarkDown1 > 0 OR MarkDown2 > 0 or MarkDown3 > 0 or MarkDown4 > 0 or MarkDown5 > 0 
then 'with markdowns'
else 'no markdowns'
end as markdown_status, sum(Weekly_Sales) as total_sales, avg(Weekly_Sales) as avg_sales
from Walmart_Store_Sales.dbo.train t
left join Walmart_Store_Sales.dbo.features f
on t.Store = f.Store and t.Date = f.Date
group by 
case when MarkDown1 > 0 OR MarkDown2 > 0 or MarkDown3 > 0 or MarkDown4 > 0 or MarkDown5 > 0 
then 'with markdowns'
else 'no markdowns'
end;

