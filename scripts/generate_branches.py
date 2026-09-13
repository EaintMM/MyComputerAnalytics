import pandas as pd
from pathlib import Path


# Project paths
PROJECT_ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = PROJECT_ROOT / "data" / "raw"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


# Branch master
branches = [
    ["LLM", "LLM Branch", "LLM", "Active"],
    ["NS", "NS Branch", "NS", "Inactive"],
    ["TGI", "TGI Branch", "TGI", "Active"],
]


columns = [
    "BranchCode",
    "BranchName",
    "City",
    "Status",
]

df_branches = pd.DataFrame(branches, columns=columns)


# Save
output_file = OUTPUT_DIR / "branches.csv"

df_branches.to_csv(output_file, index=False)


# Validation
print(f"Created: {output_file}")
print(f"Number of branches: {len(df_branches)}")

print("\nBranches:")
print(df_branches.to_string(index=False))