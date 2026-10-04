-- ============================================================
-- My Computer Analytics
-- Data Validation Queries
-- ============================================================
-- Purpose:
-- Validates database integrity and verifies important business
-- calculations before the data is used for analysis and
-- dashboard reporting.
-- ============================================================


-- ============================================================
-- 1. DATABASE INTEGRITY
-- ============================================================
-- Checks the integrity of data loaded into PostgreSQL.

SELECT
    'suppliers' AS table_name,
    COUNT(*) AS row_count
FROM suppliers

UNION ALL

SELECT
    'branches',
    COUNT(*)
FROM branches

UNION ALL

SELECT
    'products',
    COUNT(*)
FROM products

UNION ALL

SELECT
    'purchases',
    COUNT(*)
FROM purchases

UNION ALL

SELECT
    'sales',
    COUNT(*)
FROM sales

UNION ALL

SELECT
    'inventory',
    COUNT(*)
FROM inventory;



-- ============================================================
-- 2. FOREIGN KEY RELATIONSHIPS
-- ============================================================
-- Checks that transaction records reference valid products,
-- branches, suppliers, and other related master data.

-- 1. Products → Suppliers
SELECT COUNT(*) AS invalid_product_suppliers
FROM products p
LEFT JOIN suppliers s
    ON p.supplier_code = s.supplier_code
WHERE s.supplier_code IS NULL;

-- 2. Purchases → Branches
SELECT COUNT(*) AS invalid_purchase_branches
FROM purchases p
LEFT JOIN branches b
    ON p.branch_code = b.branch_code
WHERE b.branch_code IS NULL;

-- 3. Purchases → Suppliers
SELECT COUNT(*) AS invalid_purchase_suppliers
FROM purchases p
LEFT JOIN suppliers s
    ON p.supplier_code = s.supplier_code
WHERE s.supplier_code IS NULL;

-- 4. Purchases → Products
SELECT COUNT(*) AS invalid_purchase_products
FROM purchases p
LEFT JOIN products pr
    ON p.item_code = pr.item_code
WHERE pr.item_code IS NULL;

-- 5. Sales → Branches
SELECT COUNT(*) AS invalid_sale_branches
FROM sales s
LEFT JOIN branches b
    ON s.branch_code = b.branch_code
WHERE b.branch_code IS NULL;

-- 6. Sales → Products
SELECT COUNT(*) AS invalid_sale_products
FROM sales s
LEFT JOIN products p
    ON s.item_code = p.item_code
WHERE p.item_code IS NULL;

-- 7. Inventory → Branches
SELECT COUNT(*) AS invalid_inventory_branches
FROM inventory i
LEFT JOIN branches b
    ON i.branch_code = b.branch_code
WHERE b.branch_code IS NULL;

-- 8. Inventory → Products
SELECT COUNT(*) AS invalid_inventory_products
FROM inventory i
LEFT JOIN products p
    ON i.item_code = p.item_code
WHERE p.item_code IS NULL;



-- ============================================================
-- 3. INVENTORY BUSINESS LOGIC
-- ============================================================
-- Validates inventory reconciliation and stock calculations.

SELECT
    branch_code,
    item_code,
    opening_stock,
    purchased_qty,
    sold_qty,
    current_stock,
    opening_stock + purchased_qty - sold_qty AS calculated_stock
FROM inventory
WHERE current_stock <> (
    opening_stock + purchased_qty - sold_qty
);



-- ============================================================
-- 4. REVENUE CALCULATION
-- ============================================================
-- Verifies that stored revenue values match the expected
-- business calculation.

SELECT
    sale_id,
    quantity,
    unit_sale_price,
    revenue,
    quantity * unit_sale_price AS calculated_revenue,
    unit_cost,
    cogs,
    quantity * unit_cost AS calculated_cogs
FROM sales
WHERE revenue <> quantity * unit_sale_price
   OR cogs <> quantity * unit_cost;



-- ============================================================
-- 5. GROSS PROFIT AND MARGIN
-- ============================================================
-- Verifies gross profit and gross margin calculations.

SELECT
    sale_id,
    revenue,
    cogs,
    gross_profit,
    revenue - cogs AS calculated_gross_profit,
    gross_margin_pct,
    ROUND(
        ((revenue - cogs) / NULLIF(revenue, 0)) * 100,
        2
    ) AS calculated_gross_margin_pct
FROM sales
WHERE gross_profit <> revenue - cogs
   OR gross_margin_pct <> ROUND(
        ((revenue - cogs) / NULLIF(revenue, 0)) * 100,
        2
   );