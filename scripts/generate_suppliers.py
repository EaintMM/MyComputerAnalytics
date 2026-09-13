import pandas as pd
from pathlib import Path


# Project paths
PROJECT_ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = PROJECT_ROOT / "data" / "raw"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


# Supplier master
suppliers = [
    ["SUP001", "ABC Supplier", "Accessories & Components"],
    ["SUP002", "XYZ Supplier", "Accessories & Storage"],
    ["SUP003", "Tech Supplier", "Computer Accessories"],
    ["SUP004", "Local Supplier", "General Accessories"],
    ["SUP005", "Network Supplier", "Networking Equipment"],
    ["SUP006", "Software Supplier", "Software & Licenses"],
    ["SUP007", "Computer Supplier", "Computers & Monitors"],
]


columns = [
    "SupplierCode",
    "SupplierName",
    "SupplierCategory",
]

df_suppliers = pd.DataFrame(suppliers, columns=columns)


# Save
output_file = OUTPUT_DIR / "suppliers.csv"

df_suppliers.to_csv(output_file, index=False)


# Validation
print(f"Created: {output_file}")
print(f"Number of suppliers: {len(df_suppliers)}")

print("\nSuppliers:")
print(df_suppliers.to_string(index=False))