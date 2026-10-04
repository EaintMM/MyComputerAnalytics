# Business Insights

> **Important:** All numerical results in this document are based on the
> synthetic portfolio dataset. They demonstrate the analytical capabilities
> of the project and do not represent the actual performance of the business.

## 1. Overview

The analytics platform was designed to help a small computer retail and
service business understand sales performance, profitability, branch
performance, product performance, and inventory.

The analysis combines sales and inventory data through PostgreSQL and SQL
analytics views. The results are presented through the Google Data Studio
dashboard.

The analysis focuses on five main areas:

1. Overall business performance
2. Branch performance
3. Product category performance
4. Product-level profitability
5. Inventory position and stock coverage

---

# 2. Overall Business Performance

For the January–August 2026 synthetic sales period:

| Metric | Result |
|---|---:|
| Total Revenue | 692.46M MMK |
| Total COGS | 536.40M MMK |
| Gross Profit | 156.06M MMK |
| Gross Margin | 22.54% |

The synthetic dataset generated approximately **156.06M MMK in gross profit
from 692.46M MMK in revenue**, resulting in an overall gross margin of
**22.54%**.

In other words, for every 100 MMK of revenue, approximately 22.54 MMK
remained as gross profit before operating expenses and other business costs.

### Interpretation

Revenue alone does not provide a complete picture of business performance.
Gross profit and gross margin provide additional information about how much
value different sales activities contribute after product costs.

The dashboard therefore reports revenue, COGS, gross profit, and gross
margin together rather than relying on revenue as the only performance
indicator.

---

# 3. Branch Performance

The synthetic dataset contains two active branches:

| Branch | Revenue | Gross Profit | Gross Margin |
|---|---:|---:|---:|
| TGI | 369.40M MMK | 82.67M MMK | 22.38% |
| LLM | 323.05M MMK | 73.39M MMK | 22.72% |

TGI generated approximately **14.4% more revenue** than LLM during the
synthetic sales period.

However, the gross margins are very similar:

- TGI: 22.38%
- LLM: 22.72%

The difference is only **0.34 percentage points**.

### Interpretation

The results demonstrate that higher sales volume does not necessarily mean
a substantially different margin profile.

For management analysis, branch performance should therefore consider both:

- Sales volume
- Profitability

A branch generating more revenue should not automatically be considered
more efficient or more profitable without examining its margin and cost
structure.

> **Caution:** The synthetic dataset does not contain enough operational
> information to explain why the branches differ in revenue. No causal
> conclusion should be drawn from this comparison.

---

# 4. Category Performance

The synthetic dataset shows substantial differences between product
categories.

| Category | Units Sold | Revenue | Gross Profit | Gross Margin |
|---|---:|---:|---:|---:|
| Computer | 266 | 430.10M MMK | 73.00M MMK | 16.97% |
| Accessories | 5,568 | 74.25M MMK | 32.95M MMK | 44.38% |
| Storage | 576 | 66.82M MMK | 15.56M MMK | 23.29% |
| Components | 583 | 43.93M MMK | 11.23M MMK | 25.56% |
| Software | 419 | 39.43M MMK | 11.75M MMK | 29.80% |
| Networking | 568 | 37.92M MMK | 11.57M MMK | 30.52% |

## 4.1 Computers: High Revenue, Lower Margin

The Computer category is the largest contributor to revenue, generating
approximately **430.10M MMK**, or about **62% of total revenue**.

However, its gross margin is only **16.97%**, which is lower than every
other category in the synthetic dataset.

### Interpretation

This demonstrates an important business-analysis principle:

> A category can be the largest source of revenue without having the
> highest profitability.

For a real business, this type of analysis could support further
investigation into:

- Product pricing
- Supplier costs
- Product mix
- Discounts
- Competitive pricing
- Opportunities to increase margin

The current synthetic dataset does not provide enough information to
determine which of these factors is responsible.

---

## 4.2 Accessories: Lower Revenue, High Margin

Accessories generate approximately **74.25M MMK** in revenue, considerably
less than Computers.

However, the category has a **44.38% gross margin**, the highest among the
categories analyzed.

Accessories also generate approximately **32.95M MMK in gross profit**.

### Interpretation

Accessories demonstrate why revenue ranking and profitability ranking
should be analyzed separately.

Although Accessories generate much less revenue than Computers, their
higher margin allows them to make a substantial contribution to gross profit.

For a real business, this could make accessory sales an important area to
monitor alongside computer sales.

---

# 5. Revenue vs. Profitability

The product analysis shows that the products generating the most revenue
are not necessarily the products with the highest gross margins.

For example:

| Product | Revenue | Gross Profit | Gross Margin |
|---|---:|---:|---:|
| Gaming Laptop | 155.10M MMK | 23.50M MMK | 15.15% |
| Business Laptop | 79.80M MMK | 11.40M MMK | 14.29% |
| Student Laptop | 78.75M MMK | 13.50M MMK | 17.14% |
| Office Desktop PC | 67.50M MMK | 13.50M MMK | 20.00% |

The Gaming Laptop is the highest-revenue product in the synthetic dataset,
but its gross margin is only **15.15%**.

Meanwhile, products with lower revenue can have stronger margins.

### Interpretation

This is why the dashboard contains separate rankings for:

- Top products by revenue
- Top products by gross profit

A management dashboard that only displays top-selling products could miss
important profitability information.

---

# 6. Top Products by Gross Profit

The highest gross-profit contributors in the synthetic dataset include:

| Product | Gross Profit | Gross Margin |
|---|---:|---:|
| Gaming Laptop | 23.50M MMK | 15.15% |
| Office Desktop PC | 13.50M MMK | 20.00% |
| Student Laptop | 13.50M MMK | 17.14% |
| Business Laptop | 11.40M MMK | 14.29% |
| Webcam | 6.12M MMK | 45.45% |
| 27-inch Monitor | 6.00M MMK | 23.08% |
| 1TB SSD | 5.32M MMK | 21.62% |

The Gaming Laptop produces the largest absolute gross profit, even though
its margin percentage is relatively low.

The Webcam provides an interesting contrast: its total gross profit is
smaller, but its **45.45% gross margin** is substantially higher.

### Interpretation

This demonstrates the difference between:

- **Gross profit amount** — how much profit a product contributes in total
- **Gross margin percentage** — how efficiently revenue converts into gross
  profit

Both measures are useful for product-level decision-making.

---

# 7. Monthly Sales Performance

The synthetic sales period covers January through August 2026.

| Month | Revenue | Gross Profit | Gross Margin |
|---|---:|---:|---:|
| January | 102.60M MMK | 21.61M MMK | 21.06% |
| February | 72.97M MMK | 16.40M MMK | 22.47% |
| March | 96.43M MMK | 21.66M MMK | 22.46% |
| April | 84.37M MMK | 19.76M MMK | 23.42% |
| May | 101.13M MMK | 22.42M MMK | 22.17% |
| June | 53.25M MMK | 13.76M MMK | 25.85% |
| July | 98.56M MMK | 21.87M MMK | 22.19% |
| August | 83.14M MMK | 18.58M MMK | 22.35% |

### Observations

**January** generated the highest monthly revenue at approximately
**102.60M MMK**.

**June** generated the lowest revenue at approximately **53.25M MMK**, but
had the highest gross margin at **25.85%**.

This demonstrates that revenue and margin can move differently.

### Interpretation

A month with lower revenue is not necessarily a month with weaker
profitability.

For example, June had the lowest revenue but the highest gross margin in
the synthetic dataset.

> **Caution:** The synthetic dataset does not contain enough information to
> explain the reasons for monthly changes. These observations should not be
> interpreted as evidence of seasonality or changes in customer behavior.

---

# 8. Inventory Position

The current synthetic inventory is concentrated in the two active branches.

| Branch | Units in Stock | Inventory Value |
|---|---:|---:|
| TGI | 12,853 | 1,374.63M MMK |
| LLM | 8,115 | 881.11M MMK |
| **Total** | **20,968** | **2,255.74M MMK** |

The combined inventory value is approximately **2.26 billion MMK**.

### Interpretation

Inventory represents a substantial amount of capital tied up in products.

This means inventory analysis is important alongside sales analysis.

The dashboard therefore tracks both:

- Current stock quantity
- Inventory value

Looking only at the number of units can be misleading because different
products have very different values.

---

# 9. Inventory Coverage

The product inventory analysis calculates historical stock coverage using
average monthly sales.

The calculation is based on:

```text
Average Monthly Units Sold =
Total Units Sold / Number of Sales Months