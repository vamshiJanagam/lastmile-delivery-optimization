SELECT 
    city,
    product_category,

    COUNT(*) AS total_orders,

    -- Total revenue
    ROUND(SUM(order_value), 0) AS total_revenue,

    -- Revenue loss
    ROUND(
        SUM(
            CASE 
                WHEN delivery_status IN ('Failed', 'Returned') 
                THEN order_value
                ELSE 0
            END
        ), 0
    ) AS revenue_loss,

    -- SLA breach cost
    ROUND(
        SUM(
            CASE 
                WHEN sla_breached = 1 
                THEN delivery_cost
                ELSE 0
            END
        ), 0
    ) AS sla_breach_cost,

    -- Total risk
    ROUND(
        SUM(
            CASE 
                WHEN delivery_status IN ('Failed', 'Returned') 
                THEN order_value
                ELSE 0
            END
        )
        +
        SUM(
            CASE 
                WHEN sla_breached = 1 
                THEN delivery_cost
                ELSE 0
            END
        ), 0
    ) AS total_risk_value,

    -- Loss %
    ROUND(
        SUM(
            CASE 
                WHEN delivery_status IN ('Failed', 'Returned') 
                THEN order_value
                ELSE 0
            END
        ) * 100.0 / NULLIF(SUM(order_value), 0),
    2) AS loss_percentage

FROM lmaq.lastmile_delivery_data
GROUP BY city, product_category
ORDER BY total_risk_value DESC;
