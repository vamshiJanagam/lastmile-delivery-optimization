-- Step 1: Monthly aggregation
WITH monthly_data AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS yr_month,
        COUNT(*) AS total_orders,
        SUM(sla_breached) AS breach_count
    FROM lmaq.lastmile_delivery_data
    GROUP BY yr_month
)

-- Step 2: Add breach % and MoM change
SELECT 
    yr_month,
    total_orders,
    breach_count,

    ROUND(breach_count * 100.0 / total_orders, 2) AS breach_pct,

    ROUND(
        (breach_count * 100.0 / total_orders) -
        LAG(breach_count * 100.0 / total_orders)
        OVER (ORDER BY yr_month),
        2
    ) AS mom_change_pct

FROM monthly_data
ORDER BY yr_month;