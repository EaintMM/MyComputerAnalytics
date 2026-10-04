-- ============================================================
-- My Computer Analytics
-- Analytics Views
-- ============================================================
-- Purpose:
-- This file contains the SQL views used by the analytics
-- and dashboard layers of the project.
--
-- View groups:
--   1. Sales Performance
--   2. Inventory Performance
--   3. Combined Business Performance
-- ============================================================


-- ============================================================
-- 1. SALES PERFORMANCE VIEWS
-- ============================================================

-- ------------------------------------------------------------
-- 1.1 Overall Sales Performance
-- Purpose:
-- Provides overall sales KPIs for the entire business.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW overall_sales_performance AS
SELECT
    SUM(quantity) AS units_sold,
    SUM(revenue) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(gross_profit) AS total_gross_profit,
    ROUND(
        SUM(gross_profit)
        / NULLIF(SUM(revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales;


-- ------------------------------------------------------------
-- 1.2 Monthly Sales Performance
-- Purpose:
-- Aggregates sales performance by month to support
-- monthly revenue and profitability trend analysis.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW monthly_sales_performance AS
SELECT
    DATE_TRUNC('month', sale_date) AS sales_month,
    SUM(quantity) AS units_sold,
    SUM(revenue) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(gross_profit) AS total_gross_profit,
    ROUND(
        SUM(gross_profit)
        / NULLIF(SUM(revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY sales_month;

SELECT *
FROM monthly_sales_performance;


-- ------------------------------------------------------------
-- 1.3 Category Sales Performance
-- Purpose:
-- Measures sales and profitability by product category.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW category_sales_performance AS
SELECT
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.revenue) AS total_revenue,
    SUM(s.cogs) AS total_cogs,
    SUM(s.gross_profit) AS total_gross_profit,
    ROUND(
        SUM(s.gross_profit)
        / NULLIF(SUM(s.revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.item_code = p.item_code
GROUP BY p.category
ORDER BY total_revenue DESC;


-- ------------------------------------------------------------
-- 1.4 Branch Sales Performance
-- Purpose:
-- Measures sales and profitability by branch.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW branch_sales_performance AS
SELECT
    branch_code,
    SUM(quantity) AS units_sold,
    SUM(revenue) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(gross_profit) AS total_gross_profit,
    ROUND(
        SUM(gross_profit)
        / NULLIF(SUM(revenue), 0) * 100,
        2
    ) AS gross_margin_pct
FROM sales
GROUP BY branch_code
ORDER BY total_revenue DESC;


-- ------------------------------------------------------------
-- 1.5 Product Sales Performance
-- Purpose:
-- Measures sales and profitability at product level.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW product_sales_performance AS
SELECT
    p.item_code,
    p.item_description,
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.revenue) AS total_revenue,
    SUM(s.cogs) AS total_cogs,
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
    p.item_code,
    p.item_description,
    p.category
ORDER BY total_revenue DESC;



-- ============================================================
-- 2. INVENTORY PERFORMANCE VIEWS
-- ============================================================

-- ------------------------------------------------------------
-- 2.1 Branch Inventory Performance
-- Purpose:
-- Summarizes inventory quantity and value by branch.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW branch_inventory_performance AS
SELECT
    branch_code,
    SUM(current_stock) AS total_units_in_stock,
    SUM(inventory_value) AS total_inventory_value
FROM inventory
GROUP BY branch_code
ORDER BY total_inventory_value DESC;


-- ------------------------------------------------------------
-- 2.2 Category Inventory Performance
-- Purpose:
-- Summarizes inventory quantity and value by category.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW category_inventory_performance AS
SELECT
    p.category,
    SUM(i.current_stock) AS total_units_in_stock,
    SUM(i.inventory_value) AS total_inventory_value
FROM inventory i
JOIN products p
    ON i.item_code = p.item_code
GROUP BY p.category
ORDER BY total_inventory_value DESC;


-- ------------------------------------------------------------
-- 2.3 Product Inventory Performance
-- Purpose:
-- Combines product sales and inventory information to
-- calculate average monthly sales and stock coverage.
-- ------------------------------------------------------------

DROP VIEW IF EXISTS product_inventory_performance;

CREATE VIEW product_inventory_performance AS

WITH inventory_by_product AS (
    SELECT
        item_code,
        SUM(current_stock) AS current_stock,
        SUM(inventory_value) AS inventory_value
    FROM inventory
    GROUP BY item_code
),

sales_period AS (
    SELECT
        COUNT(DISTINCT DATE_TRUNC('month', sale_date))::numeric
            AS sales_months
    FROM sales
),

product_metrics AS (
    SELECT
        p.item_code,
        p.item_description,
        p.category,

        i.current_stock,
        i.inventory_value,

        COALESCE(s.units_sold, 0) AS units_sold,
        COALESCE(s.total_revenue, 0) AS total_revenue,
        COALESCE(s.total_gross_profit, 0) AS total_gross_profit,
        COALESCE(s.gross_margin_pct, 0) AS gross_margin_pct,

        ROUND(
            COALESCE(s.units_sold, 0)
            / NULLIF(sp.sales_months, 0),
            2
        ) AS avg_monthly_units_sold,

        ROUND(
            i.current_stock::numeric
            / NULLIF(
                COALESCE(s.units_sold, 0)
                / NULLIF(sp.sales_months, 0),
                0
            ),
            2
        ) AS stock_coverage_months

    FROM products p

    LEFT JOIN inventory_by_product i
        ON p.item_code = i.item_code

    LEFT JOIN product_sales_performance s
        ON p.item_code = s.item_code

    CROSS JOIN sales_period sp
)

SELECT
    *,
    CASE
        WHEN stock_coverage_months < 3
            THEN 'Low Coverage'
        WHEN stock_coverage_months < 6
            THEN 'Moderate Coverage'
        WHEN stock_coverage_months < 12
            THEN 'High Coverage'
        ELSE 'Very High Coverage'
    END AS inventory_status

FROM product_metrics

ORDER BY inventory_value DESC;


-- ============================================================
-- 3. COMBINED BUSINESS PERFORMANCE VIEWS
-- ============================================================

-- ------------------------------------------------------------
-- 3.1 Branch Business Performance
-- Purpose:
-- Combines branch sales performance with inventory
-- information for management-level analysis.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW branch_business_performance AS
SELECT
    s.branch_code,
    s.units_sold,
    s.total_revenue,
    s.total_gross_profit,
    s.gross_margin_pct,
    i.total_units_in_stock,
    i.total_inventory_value
FROM branch_sales_performance s
LEFT JOIN branch_inventory_performance i
    ON s.branch_code = i.branch_code
ORDER BY s.total_revenue DESC;


-- ------------------------------------------------------------
-- 3.2 Category Business Performance
-- Purpose:
-- Combines category sales and inventory metrics.
-- ------------------------------------------------------------

DROP VIEW IF EXISTS category_business_performance;

CREATE VIEW category_business_performance AS

SELECT
    s.category,

    -- Sales
    s.units_sold,
    s.total_revenue,
    s.total_cogs,
    s.total_gross_profit,
    s.gross_margin_pct,

    -- Inventory
    COALESCE(i.total_units_in_stock, 0) AS total_units_in_stock,
    COALESCE(i.total_inventory_value, 0) AS total_inventory_value

FROM category_sales_performance s

LEFT JOIN category_inventory_performance i
    ON s.category = i.category

ORDER BY s.total_revenue DESC;