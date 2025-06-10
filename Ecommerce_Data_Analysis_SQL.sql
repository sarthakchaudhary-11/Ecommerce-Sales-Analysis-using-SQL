create database Ecommerce;
use Ecommerce;

select * from orders;

SELECT COUNT(*) FROM Orders;


-- 🔶 STEP 2: KPI Analysis
-- Q1: What is the total revenue generated?
select sum(list_price * Quantity) as Total_Revenue
from Orders;


-- Q2: What is the total cost incurred?
select sum(cost_price*quantity) as Total_cost
from Orders;



-- Q3: What is the total discount offered?
SELECT SUM((List_Price * Quantity) * Discount_Percent / 100) AS Total_Discount FROM Orders;

-- Q4: What is the total profit
SELECT SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Total_Profit FROM Orders;


-- 🔶 STEP 3: Category & Product Performance
-- Q5: Which are the top 5 product categories by revenue?
select Category, sum(list_price * quantity) as Revenue
from orders
group by category
order by Revenue desc
limit 5;


-- Q6: Which sub-categories are least profitable?
select sub_category, 
SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Total_Profit
from orders
group by sub_category
order by Total_Profit asc
limit 5;

-- 🔶 STEP 4: Time-Based Insights
-- Q7: What is the monthly sales trend?
select date_format(order_date, '%d-%m-%y') as Month ,
	   sum(List_price * Quantity) as Monthly_Revenue
from orders
group by Month 
order by Month;


-- Q8: Which month had the highest profit?
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Profit
FROM Orders
GROUP BY Month
ORDER BY Profit DESC
LIMIT 1;


SELECT State, SUM(List_Price * Quantity) AS Revenue
FROM Orders
GROUP BY State
ORDER BY Revenue DESC
LIMIT 10;



-- What is the impact of different discount ranges?
SELECT 
  CASE 
    WHEN Discount_Percent = 0 THEN 'No Discount'
    WHEN Discount_Percent BETWEEN 0.01 AND 10 THEN '0-10%'
    WHEN Discount_Percent BETWEEN 10.01 AND 20 THEN '10-20%'
    ELSE '20%+'
  END AS Discount_Bucket,
  COUNT(*) AS Order_Count,
  SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Profit
FROM Orders
GROUP BY Discount_Bucket;

-- What are the top 3 profitable sub-categories per category?(Most Important)
SELECT *
FROM (
    SELECT Category, Sub_Category,
           SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Profit,
           RANK() OVER (PARTITION BY Category ORDER BY SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) DESC) AS rnk
    FROM Orders
    GROUP BY Category, Sub_Category
) AS ranked
WHERE rnk <= 3;






