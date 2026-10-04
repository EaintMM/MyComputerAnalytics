-- ============================================================
-- My Computer Analytics
-- Business Analysis Queries
-- ============================================================
-- Purpose:
-- Contains exploratory and business-analysis queries used to
-- investigate sales, profitability, product, category, branch,
-- and monthly performance.
-- ============================================================


-- ============================================================
-- 1. OVERALL SALES PERFORMANCE
-- ============================================================
-- Business question:
-- What is the overall sales and profitability performance?

SELECT
    SUM(revenue) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(gross_profit) AS total_gross_profit,
    ROUND(
        SUM(gross_profit) / NULLIF(SUM(revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales;


-- ============================================================
-- 2. BRANCH COMPARISON
-- ============================================================
-- Business question:
-- How does sales performance differ between branches?

SELECT
    branch_code,
    SUM(revenue) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(gross_profit) AS total_gross_profit,
    ROUND(
        SUM(gross_profit) / NULLIF(SUM(revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales
GROUP BY branch_code
ORDER BY total_revenue DESC;


-- ============================================================
-- 3. CATEGORY REVENUE
-- ============================================================
-- Business question:
-- Which product categories generate the most revenue?

SELECT
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.revenue) AS total_revenue,
    SUM(s.cogs) AS total_cogs,
    SUM(s.gross_profit) AS total_gross_profit,
    ROUND(
        SUM(s.gross_profit) / NULLIF(SUM(s.revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.item_code = p.item_code
GROUP BY p.category
ORDER BY total_revenue DESC;


-- ============================================================
-- 4. PRODUCT REVENUE ANALYSIS
-- ============================================================
-- Business question:
-- Which products generate the most revenue?

SELECT
    p.item_code,
    p.item_description,
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.revenue) AS total_revenue,
    SUM(s.gross_profit) AS total_gross_profit,
    ROUND(
        SUM(s.gross_profit) / NULLIF(SUM(s.revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.item_code = p.item_code
GROUP BY
    p.item_code,
    p.item_description,
    p.category
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 5. PRODUCT PROFITABILITY
-- ============================================================
-- Business question:
-- Which products contribute the most to profitability?

SELECT
    p.item_code,
    p.item_description,
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.revenue) AS total_revenue,
    SUM(s.gross_profit) AS total_gross_profit,
    ROUND(
        SUM(s.gross_profit) / NULLIF(SUM(s.revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.item_code = p.item_code
GROUP BY
    p.item_code,
    p.item_description,
    p.category
ORDER BY total_gross_profit DESC
LIMIT 10;


-- ============================================================
-- 6. COMPUTER PRICING ANALYSIS
-- ============================================================
-- Business question:
-- How do pricing and profitability compare for computer products?

SELECT
    p.item_code,
    p.item_description,
    s.branch_code,
    SUM(s.quantity) AS units_sold,
    ROUND(
        SUM(s.revenue) / NULLIF(SUM(s.quantity), 0),
        2
    ) AS avg_selling_price,
    ROUND(
        SUM(s.cogs) / NULLIF(SUM(s.quantity), 0),
        2
    ) AS avg_unit_cost,
    SUM(s.gross_profit) AS total_gross_profit,
    ROUND(
        SUM(s.gross_profit) / NULLIF(SUM(s.revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.item_code = p.item_code
WHERE p.category = 'Computer'
GROUP BY
    p.item_code,
    p.item_description,
    s.branch_code
ORDER BY
    p.item_code,
    s.branch_code;


-- ============================================================
-- 7. MONTHLY SALES TREND
-- ============================================================
-- Business question:
-- How do sales and profitability change over time?

SELECT
    DATE_TRUNC('month', sale_date) AS sales_month,
    SUM(quantity) AS units_sold,
    SUM(revenue) AS total_revenue,
    SUM(gross_profit) AS total_gross_profit,
    ROUND(
        SUM(gross_profit) / NULLIF(SUM(revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY sales_month;


-- ============================================================
-- 8. MONTHLY PERFORMANCE BY CATEGORY
-- ============================================================
-- Business question:
-- How does category performance change from month to month?

SELECT
    DATE_TRUNC('month', s.sale_date) AS sales_month,
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.revenue) AS total_revenue,
    SUM(s.gross_profit) AS total_gross_profit,
    ROUND(
        SUM(s.gross_profit)
        / NULLIF(SUM(s.revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.item_code = p.item_code
GROUP BY
    DATE_TRUNC('month', s.sale_date),
    p.category
ORDER BY
    sales_month,
    total_revenue DESC;