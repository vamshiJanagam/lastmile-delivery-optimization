# 🚚 Last Mile Delivery Analytics & SLA Performance

## 📌 Project Overview

This project analyzes last-mile delivery operations to identify **SLA breaches**, **delivery inefficiencies**, and **revenue at risk**. Using SQL, the analysis evaluates operational performance, customer impact, and financial losses due to delays and failed deliveries.

---

## 🎯 Objectives

* Measure SLA breach rates across cities and zones
* Identify underperforming drivers
* Analyze delivery trends over time
* Evaluate impact of external factors (weather)
* Quantify **revenue loss and operational cost due to SLA breaches and failures**

---

## 🛠 Tools Used

* **SQL (MySQL)** – Data extraction and analysis
* **Excel / Power Query** – Data cleaning and preprocessing
* *(Optional)* Power BI – Visualization and dashboarding

---

## 📊 Dataset

* Last-mile delivery dataset (~45,000 records)
* Includes:

  * Order details (order_date, city, zone, product_category)
  * Delivery metrics (promised_days, actual_days, delay_days)
  * SLA indicator (sla_breached)
  * Financials (order_value, delivery_cost)
  * Operational data (driver_id, weather_condition, delivery_status)

---

## 🔍 Key Analysis Performed

### 1️⃣ SLA Breach Analysis

* Calculated SLA breach rate by **city and zone**
* Ranked locations based on performance

---

### 2️⃣ Driver Performance Analysis

* Identified underperforming drivers using:

  * Average delay
  * SLA breach count
  * Customer rating

---

### 3️⃣ Delivery Trend Analysis

* Analyzed monthly delivery performance
* Used **window functions (LAG)** to track month-over-month changes

---

### 4️⃣ Weather Impact Analysis

* Evaluated how weather conditions affect:

  * Delivery delays
  * SLA breaches
  * Customer experience

---

### 5️⃣ Revenue at Risk Analysis

* Calculated:

  * Revenue loss due to failed/returned deliveries
  * Cost impact of SLA breaches
  * Total financial risk

---

### 6️⃣ Dynamic Analysis (Stored Procedure)

* Built a reusable stored procedure to:

  * Filter by city
  * Filter by date range
  * Dynamically calculate revenue at risk

---

## 💡 Key Insights

* Certain cities show significantly higher SLA breach rates
* Delivery delays directly impact customer satisfaction and operational cost
* Failed deliveries lead to direct revenue loss
* Weather conditions significantly affect delivery performance
* High-value orders contribute most to financial risk

---

## 📁 Project Structure

```text
lastmile-delivery-analysis/
│
├── data/
│   └── raw_data.csv
│
├── python/
│   ├── data_cleaning.py
│   ├── analysis.py
│   └── visualization.py
│
├── powerbi/
│   └── dashboard.pbix
│
├── sql/
│   ├── sla_breach_analysis.sql
│   ├── driver_performance_analysis.sql
│   ├── monthly_trend_analysis.sql
│   ├── weather_impact_analysis.sql
│   ├── revenue_at_risk_analysis.sql
│   └── revenue_at_risk_procedure.sql
│
└── README.md
```

---

## 🚀 How to Run

1. Import dataset into MySQL
2. Execute SQL scripts from `/sql` folder
3. Run stored procedure:

```sql
CALL get_revenue_at_risk('Delhi', '2024-01-01', '2024-12-31');
```

---

## 💼 Business Value

This analysis helps:

* Improve delivery efficiency
* Reduce SLA breaches
* Minimize operational costs
* Reduce revenue loss
* Enhance customer experience

---

## 👤 Author

Vamshi
Aspiring Data Analyst | SQL | Excel | Power BI
