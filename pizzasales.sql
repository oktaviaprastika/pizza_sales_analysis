SELECT * FROM pizza_sales;

-- Total Revenue
SELECT SUM(total_price) AS total_revenue FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold FROM pizza_sales;

-- Monthly Sales Trends
SELECT
	DATE_FORMAT(ORDER_DATE, '%Y-%m') AS ORDER_MONTH,
    SUM(TOTAL_PRICE) AS MONTHLY_REVENUE
FROM PIZZA_SALES
GROUP BY ORDER_MONTH
ORDER BY ORDER_MONTH desc;

-- Hourly Sales Trends
SELECT
	HOUR(ORDER_TIME) AS ORDER_HOUR,
    SUM(TOTAL_PRICE) AS HOURLY_REVENUE
FROM PIZZA_SALES
GROUP BY ORDER_HOUR
ORDER BY HOURLY_REVENUE DESC;

-- Revenue Per Pizza Category
SELECT 
	PIZZA_CATEGORY,
	SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY PIZZA_CATEGORY
ORDER BY TOTAL_REVENUE DESC;

-- Top 5 Best-Selling Pizzas
SELECT
	pizza_name,
    SUM(quantity) AS TOTAL_SOLD
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_SOLD DESC
LIMIT 5;

-- Top 5 Pizzas By Revenue
SELECT
	pizza_name,
    SUM(total_price) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE DESC
LIMIT 5;

-- Pizza Sales by Size
SELECT
	PIZZA_SIZE,
    SUM(QUANTITY) AS TOTAL_SOLD
FROM pizza_sales
GROUP BY PIZZA_SIZE
ORDER BY TOTAL_SOLD DESC;

-- Pizza Sales by Category
SELECT
	PIZZA_CATEGORY,
    SUM(QUANTITY) AS TOTAL_SOLD
FROM pizza_sales
GROUP BY PIZZA_CATEGORY
ORDER BY TOTAL_SOLD DESC;

-- Top Pizza Ingredients
SELECT
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(T1.pizza_ingredients, ',', T2.n), ',', -1)) AS ingredient,
    COUNT(*) AS frequency
FROM pizza_sales T1
INNER JOIN
	(SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) T2 
	ON T2.n <= LENGTH(T1.pizza_ingredients) - LENGTH(REPLACE(T1.pizza_ingredients, ',', '')) + 1
GROUP BY ingredient
ORDER BY frequency DESC;

-- Pizzas per Order
SELECT
    AVG(total_pizza) AS average_order_pizza
FROM
    (SELECT
		order_id,
		SUM(quantity) AS total_pizza
	FROM pizza_sales
	GROUP BY order_id) AS subquery;

-- Revenue per Order
SELECT
    AVG(total_price) AS average_order_value
FROM
    (SELECT
		order_id,
        SUM(total_price) AS total_price
	FROM pizza_sales
    GROUP BY order_id) AS subquery;

-- Daily Sales Trend
SELECT
	DAYNAME(ORDER_DATE) AS Day_of_week,
    SUM(total_price) as Total_revenue
from pizza_sales
group by Day_of_week
Order by Total_revenue DESC;