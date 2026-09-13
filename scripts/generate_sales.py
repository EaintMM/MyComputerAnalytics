import pandas as pd
import numpy as np

# Load product data
products = pd.read_csv("data/raw/products.csv")

# Set random seed so results are reproducible
np.random.seed(42)

# Number of sales transactions
num_sales = 3000

# Give each category a different probability of being sold
category_weights = {
    "Accessories": 0.40,
    "Storage": 0.15,
    "Components": 0.15,
    "Networking": 0.10,
    "Software": 0.10,
    "Computer": 0.10
}

# Calculate the probability for each product
products["SalesWeight"] = products["Category"].map(category_weights)

# Normalize weights so they add up to 1
products["SalesProbability"] = (
    products["SalesWeight"] / products["SalesWeight"].sum()
)

sales = []

for sale_id in range(1, num_sales + 1):

    # Random sale date
    sale_date = pd.Timestamp("2026-01-01") + pd.Timedelta(
        days=np.random.randint(0, 243)
    )

    # Branch distribution
    branch = np.random.choice(
        ["LLM", "TGI"],
        p=[0.45, 0.55]
    )

    # Select product based on sales probability
    product_index = np.random.choice(
        products.index,
        p=products["SalesProbability"]
    )

    product = products.loc[product_index]

    category = product["Category"]

    # Quantity based on category
    
    if category == "Computer":
        quantity = 1

    elif category in ["Components", "Storage"]:
        quantity = np.random.randint(1, 4)

    else:
        quantity = np.random.randint(1, 6)

    # Prices
    unit_cost = product["BuyPrice"]
    unit_sale_price = product["SellPrice_LL"]

    # Financial calculations
    revenue = quantity * unit_sale_price
    cogs = quantity * unit_cost
    gross_profit = revenue - cogs
    gross_margin_pct = (gross_profit / revenue) * 100

    sales.append({
        "SaleID": f"S{sale_id:05d}",
        "SaleDate": sale_date,
        "BranchCode": branch,
        "ItemCode": product["ItemCode"],
        "Quantity": quantity,
        "UnitSalePrice": unit_sale_price,
        "UnitCost": unit_cost,
        "Revenue": revenue,
        "COGS": cogs,
        "GrossProfit": gross_profit,
        "GrossMarginPct": gross_margin_pct
    })

# Convert to DataFrame
sales_df = pd.DataFrame(sales)

# Save the sales data
sales_df.to_csv(
    "data/raw/sales.csv",
    index=False
)

print("Sales data generated successfully!")
print(f"Number of sales transactions: {len(sales_df)}")
print(sales_df.head())