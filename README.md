# My Computer Analytics

A business analytics platform developed for a small computer retail and service business to support sales, inventory, purchasing, profitability, and branch-level decision-making.

> **Project Status:** 🚧 In Development  
> **Portfolio Version:** Uses synthetic data to protect confidential business information

## Overview

This project was developed for a real small computer retail and service business operating across multiple branches.

The goal is to build a lightweight business analytics platform that transforms operational business data into reliable metrics, interactive dashboards, and actionable insights for management.

The actual project works with the business's operational data. However, because this data is private and commercially sensitive, the public portfolio version uses synthetic data.

The synthetic dataset follows the structure and analytical workflow of the real project while containing no confidential business information. Therefore, the dashboard, SQL analysis, and data pipeline can be demonstrated publicly without exposing the business's actual transactions or performance.

The platform is designed to integrate:

- Product and supplier information
- Purchase transactions
- Sales transactions
- Branch-level inventory
- Pricing and profitability
- Business performance dashboards
- Inventory and sales analysis
- Decision-support insights and alerts

## Project Architecture

```text
Operational Business Data
        ↓
     Python ETL
        ↓
   PostgreSQL / Supabase
        ↓
        SQL
        ↓
   Google Data Studio
        ↓
 Management Dashboard
