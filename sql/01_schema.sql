-- ============================================================
-- My Computer Analytics
-- Database Schema
-- ============================================================
-- Purpose:
-- Defines the relational database structure used by the
-- My Computer Analytics project.
--
-- Main tables:
--   1. Suppliers
--   2. Branches
--   3. Products
--   4. Purchases
--   5. Sales
--   6. Inventory
-- ============================================================


-- ============================================================
-- DATABASE SCHEMA
-- ============================================================

-- 1. Suppliers
CREATE TABLE suppliers (
    supplier_code VARCHAR(20) PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL
);


-- 2. Branches
CREATE TABLE branches (
    branch_code VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL
);


-- 3. Products
CREATE TABLE products (
    item_code VARCHAR(20) PRIMARY KEY,
    item_description VARCHAR(200) NOT NULL,
    category VARCHAR(50) NOT NULL,
    supplier_code VARCHAR(20) NOT NULL,

    CONSTRAINT fk_product_supplier
        FOREIGN KEY (supplier_code)
        REFERENCES suppliers(supplier_code)
);


-- 4. Purchases
CREATE TABLE purchases (
    purchase_id VARCHAR(20) PRIMARY KEY,
    purchase_date DATE NOT NULL,
    branch_code VARCHAR(10) NOT NULL,
    supplier_code VARCHAR(20) NOT NULL,
    item_code VARCHAR(20) NOT NULL,
    quantity INTEGER NOT NULL,
    unit_buy_price NUMERIC(12,2) NOT NULL,
    total_cost NUMERIC(14,2) NOT NULL,

    CONSTRAINT fk_purchase_branch
        FOREIGN KEY (branch_code)
        REFERENCES branches(branch_code),

    CONSTRAINT fk_purchase_supplier
        FOREIGN KEY (supplier_code)
        REFERENCES suppliers(supplier_code),

    CONSTRAINT fk_purchase_product
        FOREIGN KEY (item_code)
        REFERENCES products(item_code)
);


-- 5. Sales
CREATE TABLE sales (
    sale_id VARCHAR(20) PRIMARY KEY,
    sale_date DATE NOT NULL,
    branch_code VARCHAR(10) NOT NULL,
    item_code VARCHAR(20) NOT NULL,
    quantity INTEGER NOT NULL,
    unit_sale_price NUMERIC(12,2) NOT NULL,
    unit_cost NUMERIC(12,2) NOT NULL,
    revenue NUMERIC(14,2) NOT NULL,
    cogs NUMERIC(14,2) NOT NULL,
    gross_profit NUMERIC(14,2) NOT NULL,
    gross_margin_pct NUMERIC(6,2) NOT NULL,

    CONSTRAINT fk_sale_branch
        FOREIGN KEY (branch_code)
        REFERENCES branches(branch_code),

    CONSTRAINT fk_sale_product
        FOREIGN KEY (item_code)
        REFERENCES products(item_code)
);


-- 6. Inventory
CREATE TABLE inventory (
    branch_code VARCHAR(10) NOT NULL,
    item_code VARCHAR(20) NOT NULL,
    opening_stock INTEGER NOT NULL,
    purchased_qty INTEGER NOT NULL,
    sold_qty INTEGER NOT NULL,
    current_stock INTEGER NOT NULL,
    unit_cost NUMERIC(12,2) NOT NULL,
    inventory_value NUMERIC(14,2) NOT NULL,

    PRIMARY KEY (branch_code, item_code),

    CONSTRAINT fk_inventory_branch
        FOREIGN KEY (branch_code)
        REFERENCES branches(branch_code),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (item_code)
        REFERENCES products(item_code)
);

ALTER TABLE suppliers
ADD COLUMN supplier_category VARCHAR(100);