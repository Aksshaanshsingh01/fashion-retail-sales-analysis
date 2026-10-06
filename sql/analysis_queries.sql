-- ============================================================
-- Fashion Retail Sales Analysis
-- SQL Analysis Queries
-- Database: fashion_retail
-- Table: fashion_sales_staging
-- ============================================================

USE fashion_retail;

-- ------------------------------------------------------------
-- 01. DATASET OVERVIEW
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS transactions,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(purchase_amount), 2) AS total_revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_transaction_value,
    MIN(purchase_date) AS first_purchase,
    MAX(purchase_date) AS last_purchase
FROM fashion_sales_staging;


-- ------------------------------------------------------------
-- 02. REVENUE BY ITEM
-- Business question: Which products generate the most revenue?
-- ------------------------------------------------------------

SELECT
    item,
    COUNT(*) AS transactions,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_transaction_value
FROM fashion_sales_staging
GROUP BY item
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- 03. MONTHLY REVENUE TREND
-- Business question: How does revenue change over time?
-- ------------------------------------------------------------

SELECT
    DATE_FORMAT(purchase_date, '%Y-%m') AS month,
    ROUND(SUM(purchase_amount), 2) AS monthly_revenue
FROM fashion_sales_staging
GROUP BY DATE_FORMAT(purchase_date, '%Y-%m')
ORDER BY month;


-- ------------------------------------------------------------
-- 04. CUMULATIVE REVENUE USING A WINDOW FUNCTION
-- Business question: How quickly does revenue accumulate over time?
-- ------------------------------------------------------------

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(purchase_date, '%Y-%m') AS month,
        SUM(purchase_amount) AS monthly_revenue
    FROM fashion_sales_staging
    GROUP BY DATE_FORMAT(purchase_date, '%Y-%m')
)
SELECT
    month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_revenue
FROM monthly_revenue
ORDER BY month;


-- ------------------------------------------------------------
-- 05. REVENUE BY PAYMENT METHOD
-- Business question: Which payment method contributes more revenue?
-- ------------------------------------------------------------

SELECT
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_transaction_value,
    ROUND(
        SUM(purchase_amount) * 100.0 /
        SUM(SUM(purchase_amount)) OVER (),
        2
    ) AS revenue_share_pct
FROM fashion_sales_staging
GROUP BY payment_method
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- 06. TOP 10 CUSTOMERS BY REVENUE
-- Business question: Who are the highest-value customers?
-- ------------------------------------------------------------

SELECT
    customer_id,
    COUNT(*) AS transactions,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_transaction_value
FROM fashion_sales_staging
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 07. REVENUE AND CUSTOMER SATISFACTION BY ITEM
-- Business question: Does customer satisfaction vary by item?
-- ------------------------------------------------------------

SELECT
    item,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(review_rating), 2) AS avg_review_rating,
    COUNT(review_rating) AS rated_transactions
FROM fashion_sales_staging
GROUP BY item
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- 08. REVENUE BY PRICE BAND
-- Business question: Which price bands drive revenue?
-- ------------------------------------------------------------

SELECT
    price_band,
    COUNT(*) AS transactions,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_transaction_value
FROM fashion_sales_staging
GROUP BY price_band
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- 09. QUARTERLY REVENUE
-- Business question: Which quarters performed best?
-- ------------------------------------------------------------

SELECT
    quarter,
    COUNT(*) AS transactions,
    ROUND(SUM(purchase_amount), 2) AS revenue
FROM fashion_sales_staging
GROUP BY quarter
ORDER BY quarter;


-- ------------------------------------------------------------
-- 10. ITEM REVENUE RANKING
-- Business question: How do products rank by revenue?
-- Demonstrates RANK() window function.
-- ------------------------------------------------------------

WITH item_revenue AS (
    SELECT
        item,
        SUM(purchase_amount) AS revenue
    FROM fashion_sales_staging
    GROUP BY item
)
SELECT
    item,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM item_revenue
ORDER BY revenue_rank;


-- ------------------------------------------------------------
-- 11. CUSTOMER REVENUE SEGMENTATION
-- Business question: How much revenue comes from different
-- customer-value groups?
-- ------------------------------------------------------------

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(purchase_amount) AS revenue
    FROM fashion_sales_staging
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN revenue >= 5000 THEN 'High Value'
        WHEN revenue >= 2500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(AVG(revenue), 2) AS avg_customer_revenue
FROM customer_revenue
GROUP BY
    CASE
        WHEN revenue >= 5000 THEN 'High Value'
        WHEN revenue >= 2500 THEN 'Medium Value'
        ELSE 'Low Value'
    END
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- 12. TOP ITEMS WITH ABOVE-AVERAGE REVENUE
-- Business question: Which products outperform the average item?
-- Demonstrates a CTE + aggregate comparison.
-- ------------------------------------------------------------

WITH item_revenue AS (
    SELECT
        item,
        SUM(purchase_amount) AS revenue
    FROM fashion_sales_staging
    GROUP BY item
)
SELECT
    item,
    ROUND(revenue, 2) AS revenue
FROM item_revenue
WHERE revenue > (
    SELECT AVG(revenue)
    FROM item_revenue
)
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- 13. DATA QUALITY CHECK
-- Check missing review ratings and unusual/unknown price bands.
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    SUM(review_rating IS NULL) AS missing_review_ratings,
    SUM(price_band = 'Unknown') AS unknown_price_bands
FROM fashion_sales_staging;


-- ------------------------------------------------------------
-- 14. PAYMENT METHOD PERFORMANCE WITH SATISFACTION
-- Combines revenue and average customer rating.
-- ------------------------------------------------------------

SELECT
    payment_method,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    COUNT(*) AS transactions,
    ROUND(AVG(review_rating), 2) AS avg_review_rating
FROM fashion_sales_staging
GROUP BY payment_method
ORDER BY revenue DESC;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
