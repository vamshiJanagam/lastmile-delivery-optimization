# %%
# ==============================
# 📦 Imports & Setup
# ==============================

import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path
import os

# Base directory
BASE_DIR = Path(__file__).parent

# Create outputs folder automatically
os.makedirs(BASE_DIR / "outputs", exist_ok=True)

# ==============================
# 📂 Load Data
# ==============================

df = pd.read_csv(BASE_DIR / "data" / "lastmile_delivery_data.csv")

# Preview
print(df.head())

# ==============================
# 📊 Overall SLA Breach %
# ==============================

total_orders = df['ORDER ID'].count()
total_breached = df['SLA BREACHED'].sum()

breach_pct = (total_breached / total_orders) * 100

print("Total Orders:", total_orders)
print("Total Breached:", total_breached)
print("SLA Breach %:", round(breach_pct, 2))

# ==============================
# 📆 Monthly Trend
# ==============================

df['ORDER DATE'] = pd.to_datetime(df['ORDER DATE'])
df['Month'] = df['ORDER DATE'].dt.to_period('M')

# SLA BREACHED is binary (1 = breached, 0 = on time), so mean * 100 gives breach %
monthly_trend = df.groupby('Month')['SLA BREACHED'].mean() * 100

plt.figure(figsize=(10, 6))
monthly_trend.plot()

plt.title('Monthly SLA Breach Trend')
plt.xlabel('Month')
plt.ylabel('Breach %')

plt.tight_layout()
plt.savefig(BASE_DIR / "outputs" / "monthly_trend.png", dpi=150)
plt.show()

# ==============================
# 🏙️ City Analysis
# ==============================

city_analysis = df.groupby('CITY').agg({
    'SLA BREACHED': 'sum',
    'ORDER ID': 'count'
})

city_analysis['Breach %'] = (
    city_analysis['SLA BREACHED'] / city_analysis['ORDER ID']
) * 100

# ==============================
# 🔴 Top 5 Cities
# ==============================

top_5_cities = city_analysis.sort_values(by='Breach %', ascending=False).head(5)

print("\nTop 5 Cities:\n", top_5_cities)

plt.figure(figsize=(10, 6))
top_5_cities['Breach %'].plot(kind='barh', color='red')

plt.title('Top 5 Cities by SLA Breach Rate')
plt.xlabel('Breach %')
plt.ylabel('City')

plt.gca().invert_yaxis()

for i, v in enumerate(top_5_cities['Breach %']):
    plt.text(v, i, f"{v:.2f}%", va='center')

plt.tight_layout()
plt.savefig(BASE_DIR / "outputs" / "top5_sla_breach.png", dpi=150)
plt.show()

# ==============================
# 🟢 Bottom 5 Cities
# ==============================

bottom_5_cities = city_analysis.sort_values(by='Breach %', ascending=True).head(5)

print("\nBottom 5 Cities:\n", bottom_5_cities)

plt.figure(figsize=(10, 6))
bottom_5_cities['Breach %'].plot(kind='barh', color='skyblue')

plt.title('Bottom 5 Cities by SLA Breach Rate')
plt.xlabel('Breach %')
plt.ylabel('City')

plt.gca().invert_yaxis()

for i, v in enumerate(bottom_5_cities['Breach %']):
    plt.text(v, i, f"{v:.2f}%", va='center')

plt.tight_layout()
plt.savefig(BASE_DIR / "outputs" / "bottom5_sla_breach.png", dpi=150)
plt.show()

# ==============================
# 🚚 Vehicle Type Analysis
# ==============================

vehicle_analysis = df.groupby('VEHICLE TYPE').agg({
    'SLA BREACHED': 'sum',
    'ORDER ID': 'count'
})

vehicle_analysis['Breach %'] = (
    vehicle_analysis['SLA BREACHED'] / vehicle_analysis['ORDER ID']
) * 100

vehicle_analysis_sorted = vehicle_analysis.sort_values('Breach %', ascending=False)

print("\nVehicle Analysis:\n", vehicle_analysis_sorted)

plt.figure(figsize=(8, 5))
vehicle_analysis_sorted['Breach %'].plot(kind='barh', color='steelblue')

plt.title('SLA Breach Rate by Vehicle Type')
plt.xlabel('Breach %')
plt.ylabel('Vehicle Type')

plt.gca().invert_yaxis()

for i, v in enumerate(vehicle_analysis_sorted['Breach %']):
    plt.text(v, i, f"{v:.2f}%", va='center')

plt.tight_layout()
plt.savefig(BASE_DIR / "outputs" / "vehicle_type_breach.png", dpi=150)
plt.show()