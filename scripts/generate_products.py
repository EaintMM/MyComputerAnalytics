import pandas as pd
from pathlib import Path


# Project paths
PROJECT_ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = PROJECT_ROOT / "data" / "raw"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


# Product master
products = [
    # Accessories
    ["MOUSE001", "Wireless Mouse", "Accessories", "ABC Supplier", 5000, 8500, 8000],
    ["MOUSE002", "Wired Mouse", "Accessories", "ABC Supplier", 3000, 5500, 5200],
    ["KB001", "USB Keyboard", "Accessories", "XYZ Supplier", 7000, 12000, 11000],
    ["KB002", "Wireless Keyboard", "Accessories", "XYZ Supplier", 12000, 19000, 17500],
    ["BAG001", "Laptop Bag 15.6\"", "Accessories", "ABC Supplier", 6500, 13500, 12500],
    ["BAG002", "Laptop Backpack", "Accessories", "ABC Supplier", 10000, 19000, 17500],
    ["HEAD001", "USB Headset", "Accessories", "Tech Supplier", 9000, 16000, 15000],
    ["CAM001", "Webcam", "Accessories", "Tech Supplier", 12000, 22000, 20500],
    ["PAD001", "Mouse Pad", "Accessories", "Local Supplier", 2500, 5000, 4500],
    ["HUB001", "USB Hub", "Accessories", "Tech Supplier", 7000, 12500, 11500],

    # Components
    ["RAM001", "8GB DDR4 RAM", "Components", "ABC Supplier", 55000, 72000, 68000],
    ["RAM002", "16GB DDR4 RAM", "Components", "ABC Supplier", 95000, 125000, 118000],
    ["PSU001", "500W Power Supply", "Components", "Tech Supplier", 65000, 85000, 80000],
    ["FAN001", "CPU Cooling Fan", "Components", "Tech Supplier", 18000, 30000, 28000],

    # Storage
    ["SSD001", "256GB SSD", "Storage", "XYZ Supplier", 55000, 75000, 70000],
    ["SSD002", "512GB SSD", "Storage", "XYZ Supplier", 80000, 105000, 98000],
    ["SSD003", "1TB SSD", "Storage", "XYZ Supplier", 145000, 185000, 175000],
    ["HDD001", "1TB HDD", "Storage", "Local Supplier", 85000, 110000, 103000],

    # Networking
    ["ROUT001", "WiFi Router", "Networking", "Network Supplier", 45000, 65000, 60000],
    ["ROUT002", "Dual Band Router", "Networking", "Network Supplier", 75000, 105000, 98000],
    ["LAN001", "LAN Cable 5m", "Networking", "Local Supplier", 5000, 9000, 8500],
    ["SW001", "8-Port Network Switch", "Networking", "Network Supplier", 55000, 80000, 75000],

    # Software
    ["SOFT001", "Antivirus License", "Software", "Software Supplier", 30000, 55600, 52000],
    ["SOFT002", "Windows License", "Software", "Software Supplier", 85000, 110000, 103000],
    ["SOFT003", "Office License", "Software", "Software Supplier", 90000, 125000, 118000],

    # Computers
    ["LAP001", "Business Laptop", "Computer", "Computer Supplier", 1800000, 2100000, 2000000],
    ["LAP002", "Student Laptop", "Computer", "Computer Supplier", 1450000, 1750000, 1650000],
    ["LAP003", "Gaming Laptop", "Computer", "Computer Supplier", 2800000, 3300000, 3100000],
    ["DESK001", "Office Desktop PC", "Computer", "Computer Supplier", 1200000, 1500000, 1400000],
    ["MON001", "24-inch Monitor", "Computer", "Computer Supplier", 350000, 450000, 425000],
    ["MON002", "27-inch Monitor", "Computer", "Computer Supplier", 500000, 650000, 610000],
]


columns = [
    "ItemCode",
    "ItemDescription",
    "Category",
    "Supplier",
    "BuyPrice",
    "SellPrice_LL",
    "DealerPrice_LL",
]

df_products = pd.DataFrame(products, columns=columns)


# Save dataset
output_file = OUTPUT_DIR / "products.csv"

df_products.to_csv(output_file, index=False)


# Validation
print(f"Created: {output_file}")
print(f"Number of products: {len(df_products)}")

print("\nCategories:")
print(df_products["Category"].value_counts())

print("\nProducts:")
print(df_products.head(10).to_string(index=False))