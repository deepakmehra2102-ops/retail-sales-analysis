#DATA SANITY CHECKS
SELECT
    COUNT(*) AS total_transactions,
    SUM(Total_Sales) AS total_sales,
    SUM(Net_Sales) AS total_net_sales
FROM fact_sales;
-- Discount impact
-- Business meaning:
-- Do discounted orders actually drive revenue?
SELECT
    Is_Discounted,
    COUNT(*) AS transactions,
    SUM(Net_Sales) AS net_sales
FROM fact_sales
GROUP BY Is_Discounted;

-- Net sales by product
-- Use case: Top-selling products.
SELECT
    p.Product_Name,
    SUM(f.Net_Sales) AS net_sales
FROM fact_sales f
JOIN dim_product p
    ON f.ProductID = p.ProductID
GROUP BY p.Product_Name
ORDER BY net_sales DESC;

-- Net sales by product line
-- Use case: Category performance.
SELECT
    p.Product_Line,
    SUM(f.Net_Sales) AS net_sales
FROM fact_sales f
JOIN dim_product p
    ON f.ProductID = p.ProductID
GROUP BY p.Product_Line
ORDER BY net_sales DESC;

-- CUSTOMER ANALYSIS
-- Top customers by revenue
-- Use case: Key customers.
SELECT
    c.Customer_Name,
    SUM(f.Net_Sales) AS net_sales
FROM fact_sales f
JOIN dim_customer c
    ON f.CustomerID = c.CustomerID
GROUP BY c.Customer_Name
ORDER BY net_sales DESC
LIMIT 10;

-- Sales by city
-- Use case: Geographic performance.
SELECT
    c.City,
    SUM(f.Net_Sales) AS net_sales
FROM fact_sales f
JOIN dim_customer c
    ON f.CustomerID = c.CustomerID
GROUP BY c.City
ORDER BY net_sales DESC;

-- PROMOTION ANALYSIS (IMPORTANT)
-- Promotion effectiveness
-- Why LEFT JOIN:
-- Includes non-promotion (NULL) sales.
SELECT
    p.Promotion_Name,
    COUNT(*) AS transactions,
    SUM(f.Net_Sales) AS net_sales
FROM fact_sales f
LEFT JOIN dim_promotion p
    ON f.PromotionID = p.PromotionID
GROUP BY p.Promotion_Name
ORDER BY net_sales DESC;

-- Discount depth vs revenue
-- Use case: Do deeper discounts help or hurt revenue?
SELECT
    Discount_Percentage,
    COUNT(*) AS transactions,
    SUM(Net_Sales) AS net_sales
FROM fact_sales
GROUP BY Discount_Percentage
ORDER BY Discount_Percentage;

-- TIME-BASED ANALYSIS
-- Use case: Seasonality.
-- Monthly sales trend
SELECT
    Year,
    Month,
    Month_Name,
    SUM(Net_Sales) AS net_sales
FROM fact_sales
GROUP BY Year, Month, Month_Name
ORDER BY Year, Month;








