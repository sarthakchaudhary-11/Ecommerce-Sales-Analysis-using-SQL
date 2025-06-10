# 🛒 Ecommerce Sales Analysis using SQL

This project focuses on extracting actionable insights from an Ecommerce dataset using **MySQL**. The analysis includes key performance indicators (KPIs), category-level and product-level insights, time-based trends, and discount impact to aid strategic business decisions.

---

## 📁 Database Setup

```sql
CREATE DATABASE Ecommerce;
USE Ecommerce;
Ensure your orders table is properly created and populated with relevant fields like:

order_id

order_date

category

sub_category

state

quantity

list_price

cost_price

discount_percent

📊 Project Steps and Queries
🔶 STEP 1: Basic Checks
sql
Copy
Edit
SELECT * FROM Orders;
SELECT COUNT(*) FROM Orders;
🔶 STEP 2: KPI Analysis
KPI	SQL Query
Total Revenue	SELECT SUM(List_Price * Quantity) AS Total_Revenue FROM Orders;
Total Cost	SELECT SUM(Cost_Price * Quantity) AS Total_Cost FROM Orders;
Total Discount	SELECT SUM((List_Price * Quantity) * Discount_Percent / 100) AS Total_Discount FROM Orders;
Total Profit	SELECT SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Total_Profit FROM Orders;

🔶 STEP 3: Category & Product Performance
Top 5 Product Categories by Revenue

sql
Copy
Edit
SELECT Category, SUM(List_Price * Quantity) AS Revenue
FROM Orders
GROUP BY Category
ORDER BY Revenue DESC
LIMIT 5;
Bottom 5 Sub-Categories by Profit

sql
Copy
Edit
SELECT Sub_Category, 
       SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Total_Profit
FROM Orders
GROUP BY Sub_Category
ORDER BY Total_Profit ASC
LIMIT 5;
🔶 STEP 4: Time-Based Insights
Monthly Revenue Trend

sql
Copy
Edit
SELECT DATE_FORMAT(Order_Date, '%d-%m-%y') AS Month,
       SUM(List_Price * Quantity) AS Monthly_Revenue
FROM Orders
GROUP BY Month
ORDER BY Month;
Month with Highest Profit

sql
Copy
Edit
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
       SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Profit
FROM Orders
GROUP BY Month
ORDER BY Profit DESC
LIMIT 1;
🔶 STEP 5: State-wise Performance
Top 10 States by Revenue

sql
Copy
Edit
SELECT State, SUM(List_Price * Quantity) AS Revenue
FROM Orders
GROUP BY State
ORDER BY Revenue DESC
LIMIT 10;
🔶 STEP 6: Discount Impact Analysis
Profit & Orders by Discount Range

sql
Copy
Edit
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
🔶 STEP 7: Top Performing Sub-Categories
Top 3 Profitable Sub-Categories per Category

sql
Copy
Edit
SELECT *
FROM (
    SELECT Category, Sub_Category,
           SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) AS Profit,
           RANK() OVER (PARTITION BY Category ORDER BY SUM((List_Price - Cost_Price) * Quantity - ((List_Price * Quantity) * Discount_Percent / 100)) DESC) AS rnk
    FROM Orders
    GROUP BY Category, Sub_Category
) AS ranked
WHERE rnk <= 3;
🧰 Tools & Technologies Used
Database: MySQL

Language: SQL

IDE: MySQL Workbench / DBeaver / VS Code

Data Format: CSV → imported into MySQL

📌 Key Learnings
Performing KPI Analysis for business metrics.

Writing aggregate queries using SUM(), GROUP BY, and conditional logic.

Creating time-based and category-based insights.

Using window functions like RANK() for grouped ranking logic.

Analyzing discount impact on profit.

📎 Dataset
The orders.csv file contains sample ecommerce transaction data. Make sure to import it into MySQL before running queries.

🧠 Future Enhancements
Integrate with Tableau or Power BI for visual dashboards.

Include customer-level segmentation analysis.

Perform predictive modeling using Python or R.

📝 Author
Sarthak Chaudhary
