SELECT 
    city,
    zone,
    total_orders,
    breached_orders,
    breach_rate_pct,

    RANK() OVER (ORDER BY breach_rate_pct DESC) AS breach_rank

FROM (
    SELECT 
        city,
        zone,
        COUNT(*) AS total_orders,
        SUM(sla_breached) AS breached_orders,
        ROUND(SUM(sla_breached) * 100.0 / COUNT(*), 2) AS breach_rate_pct
    FROM lmaq.lastmile_delivery_data
    GROUP BY city, zone
) t;