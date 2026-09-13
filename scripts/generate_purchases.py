import pandas as pd
import numpy as np
from pathlib import Path


# --------------------------------------------------
# Project paths
# --------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data" / "raw"

PRODUCT_FILE = DATA_DIR / "products.csv"
BRANCH_FILE = DATA_DIR / "branches.csv"
SUPPLIER_FILE = DATA_DIR / "suppliers.csv"

OUTPUT_FILE = DATA_DIR / "purchases.csv"


# --------------------------------------------------
# Reproducibility
# --------------------------------------------------

np.random.seed(42)


# --------------------------------------------------
# Load master data
# --------------------------------------------------

products = pd.read_csv(PRODUCT_FILE)
branches = pd.read_csv(BRANCH_FILE)
suppliers = pd.read_csv(SUPPLIER_FILE)


# Only active branches receive new purchases
active_branches = branches[
    branches["Status"] == "Active"
].copy()


# --------------------------------------------------
# Generate purchase transactions
# --------------------------------------------------

start_date = pd.Timestamp("2025-09-01")
end_date = pd.Timestamp("2026-08-31")

date_range = pd.date_range(
    start=start_date,
    end=end_date,
    freq="D"
)


purchases = []


for purchase_id in range(1, 1801):

    purchase_date = np.random.choice(date_range)

    branch = active_branches.sample(
        n=1,
        weights=[0.40, 0.60] # LLM has 40% chance, TGI has 60% chance
    ).iloc[0]

    product = products.sample(n=1).iloc[0]

    # Use the supplier associated with the product
    supplier_name = product["Supplier"]

    supplier = suppliers[
        suppliers["SupplierName"] == supplier_name
    ]

    if supplier.empty:
        supplier_code = "SUP999"
    else:
        supplier_code = supplier.iloc[0]["SupplierCode"]

    # Quantity depends on product type
    if product["Category"] == "Computer":
        quantity = np.random.randint(1, 6)

    elif product["Category"] in ["Components", "Storage"]:
        quantity = np.random.randint(3, 16)

    elif product["Category"] == "Software":
        quantity = np.random.randint(5, 31)

    else:
        quantity = np.random.randint(5, 41)

    # Simulate small supplier price fluctuations
    price_variation = np.random.uniform(0.95, 1.08)

    unit_buy_price = round(
        product["BuyPrice"] * price_variation,
        2
    )

    total_cost = round(
        quantity * unit_buy_price,
        2
    )

    purchases.append([
        f"PUR{purchase_id:05d}",
        purchase_date,
        branch["BranchCode"],
        supplier_code,
        product["ItemCode"],
        quantity,
        unit_buy_price,
        total_cost
    ])


# --------------------------------------------------
# Create DataFrame
# --------------------------------------------------

columns = [
    "PurchaseID",
    "PurchaseDate",
    "BranchCode",
    "SupplierCode",
    "ItemCode",
    "Quantity",
    "UnitBuyPrice",
    "TotalCost"
]

df_purchases = pd.DataFrame(
    purchases,
    columns=columns
)


# --------------------------------------------------
# Data types
# --------------------------------------------------

df_purchases["PurchaseDate"] = pd.to_datetime(
    df_purchases["PurchaseDate"]
)

df_purchases["Quantity"] = df_purchases["Quantity"].astype(int)


# --------------------------------------------------
# Save
# --------------------------------------------------

df_purchases.to_csv(
    OUTPUT_FILE,
    index=False
)


# --------------------------------------------------
# Validation
# --------------------------------------------------

print(f"Created: {OUTPUT_FILE}")
print(f"Number of purchase transactions: {len(df_purchases)}")

print("\nDate range:")
print(
    df_purchases["PurchaseDate"].min(),
    "to",
    df_purchases["PurchaseDate"].max()
)

print("\nPurchases by branch:")
print(
    df_purchases.groupby("BranchCode")["TotalCost"]
    .sum()
    .round(2)
)

print("\nPurchases by category:")

purchase_category = (
    df_purchases
    .merge(
        products[["ItemCode", "Category"]],
        on="ItemCode",
        how="left"
    )
    .groupby("Category")["TotalCost"]
    .sum()
    .sort_values(ascending=False)
)

print(purchase_category.round(2))

print("\nFirst 5 transactions:")
print(
    df_purchases.head().to_string(index=False)
)