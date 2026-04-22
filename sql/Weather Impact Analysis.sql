SELECT 
    weather_condition,
    ROUND(AVG(delay_days), 2) AS avg_delay,
    ROUND(SUM(sla_breached)*100.0/COUNT(*), 2) AS breach_rate,

    ROUND(AVG(delivery_cost), 2) AS avg_cost

FROM lmaq.lastmile_delivery_data
GROUP BY weather_condition;