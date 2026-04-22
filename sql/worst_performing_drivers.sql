WITH driver_stats AS (
    SELECT 
        driver_id,
        COUNT(*) AS total_deliveries,
        ROUND(AVG(delay_days), 2) AS avg_delay,
        ROUND(AVG(customer_rating), 2) AS avg_rating,
        SUM(sla_breached) AS breach_count
    FROM lmaq.lastmile_delivery_data
    GROUP BY driver_id
    HAVING COUNT(*) >= 20
)

-- Step 2: Rank drivers based on delay
SELECT 
    driver_id,
    total_deliveries,
    avg_delay,
    avg_rating,
    breach_count,

    RANK() OVER (ORDER BY avg_delay DESC) AS delay_rank

FROM driver_stats
ORDER BY avg_delay DESC
LIMIT 10;
