/*

Bs Pizzaria Data Exploration

*/

SELECT * FROM [dbo].[pizzasales]

-------------------------------------------------------------------------------------------------------------------------------------------------

-- KPI INDICATOR

-- Total Revenue
SELECT SUM(total_price) AS total_revenue FROM [dbo].[pizzasales]

-- Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS avg_order_Value FROM [dbo].[pizzasales]

-- Total Pizzas Sold
SELECT SUM(quantity) AS total_pizza_sold FROM [dbo].[pizzasales]

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_Orders FROM [dbo].[pizzasales]

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM [dbo].[pizzasales]

-------------------------------------------------------------------------------------------------------------------------------------------------

-- DAILY TREND FOR TOTAL ORDERS
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM [dbo].[pizzasales]
GROUP BY DATENAME(DW, order_date)

-------------------------------------------------------------------------------------------------------------------------------------------------

-- HOURLY TREND FOR ORDERS
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from [dbo].[pizzasales]
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

-------------------------------------------------------------------------------------------------------------------------------------------------

-- SALES PERCENTAGE BY CATEGORY
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [dbo].[pizzasales]) AS DECIMAL(10,2)) AS PCT
FROM [dbo].[pizzasales]
GROUP BY pizza_category

-------------------------------------------------------------------------------------------------------------------------------------------------

-- SALES PERCENTAGE BY SIZE
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [dbo].[pizzasales]) AS DECIMAL(10,2)) AS PCT
FROM [dbo].[pizzasales]
GROUP BY pizza_size
ORDER BY pizza_size

-------------------------------------------------------------------------------------------------------------------------------------------------

-- TOTAL PIZZA SOLD BY PIZZA CATEGORY
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM [dbo].[pizzasales]
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-------------------------------------------------------------------------------------------------------------------------------------------------

-- TOP 5 BEST SELLERS
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM [dbo].[pizzasales]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

-------------------------------------------------------------------------------------------------------------------------------------------------

-- BOTTOM 5 BEST SELELRS
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM [dbo].[pizzasales]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC





