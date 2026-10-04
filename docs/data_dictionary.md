# Data Dictionary

This document describes the main tables and fields used in the My Computer Analytics database.

> **Note:** The public portfolio dataset is synthetic. The structure is designed to represent the analytical workflow of the real business while protecting confidential business information.

---

## 1. Database Overview

The database contains six main tables:

| Table | Purpose |
|---|---|
| `suppliers` | Stores supplier master data |
| `branches` | Stores branch information |
| `products` | Stores product master data |
| `purchases` | Stores purchase transactions |
| `sales` | Stores sales transactions |
| `inventory` | Stores branch-level inventory information |

The tables are connected through primary-key and foreign-key relationships.

```text
suppliers
    │
    └──────────────┐
                   ↓
               products
                ↙    ↘
               ↓      ↓
          purchases   sales
                       │
                       ↓
                   inventory

branches ─────────────┘