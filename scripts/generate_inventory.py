import pandas as pd
import numpy as np

# Load the data
products = pd.read_csv("data/raw/products.csv")
purchases = pd.read_csv("data/raw/purchases.csv")
sales = pd.read_csv("data/raw/sales.csv")

# Active branches
branches = ["LLM", "TGI"]

# Random seed
np.random.seed(42)

inventory = []

for branch in branches:

    for _, product in products.iterrows():

        item_code = product["ItemCode"]
        unit_cost = product["BuyPrice"]

        # Create opening stock
        opening_stock = np.random.randint(10, 51)

        # Total purchased for this branch and product
        purchased_qty = purchases[
            (purchases["BranchCode"] == branch)
            & (purchases["ItemCode"] == item_code)
        ]["Quantity"].sum()

        # Total sold for this branch and product
        sold_qty = sales[
            (sales["BranchCode"] == branch)
            & (sales["ItemCode"] == item_code)
        ]["Quantity"].sum()

        # Calculate current stock
        current_stock = opening_stock + purchased_qty - sold_qty

        # Inventory value
        inventory_value = current_stock * unit_cost

        inventory.append({
            "BranchCode": branch,
            "ItemCode": item_code,
            "OpeningStock": opening_stock,
            "PurchasedQty": purchased_qty,
            "SoldQty": sold_qty,
            "CurrentStock": current_stock,
            "UnitCost": unit_cost,
            "InventoryValue": inventory_value
        })

# Convert to DataFrame
inventory_df = pd.DataFrame(inventory)

# Save
inventory_df.to_csv(
    "data/raw/inventory.csv",
    index=False
)

print("Inventory data generated successfully!")
print(f"Number of inventory records: {len(inventory_df)}")
print(inventory_df.head())