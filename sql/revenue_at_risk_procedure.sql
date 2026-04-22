DELIMITER $$
use lmaq;
CREATE PROCEDURE get_revenue_at_risk (
    IN p_city VARCHAR(50),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN

    SELECT 
        city,
        product_category,

        COUNT(*) AS total_orders,

        ROUND(SUM(order_value), 0) AS total_revenue,

        ROUND(
            SUM(
                CASE 
                    WHEN delivery_status IN ('Failed', 'Returned') 
                    THEN order_value
                    ELSE 0
                END
            ), 0
        ) AS revenue_loss,

        ROUND(
            SUM(
                CASE 
                    WHEN sla_breached = 1 
                    THEN delivery_cost
                    ELSE 0
                END
            ), 0
        ) AS sla_breach_cost,

        ROUND(
            SUM(
                CASE 
                    WHEN delivery_status IN ('Failed', 'Returned') 
                    THEN order_value
                    ELSE 0
                END
            ) +
            SUM(
                CASE 
                    WHEN sla_breached = 1 
                    THEN delivery_cost
                    ELSE 0
                END
            ), 0
        ) AS total_risk_value

    FROM lmaq.lastmile_delivery_data

    WHERE 
        (city = p_city OR p_city IS NULL)
        AND order_date BETWEEN p_start_date AND p_end_date

    GROUP BY city, product_category
    ORDER BY total_risk_value DESC;

END $$

DELIMITER ;


-- Get revenue at risk for Delhi between Jan 2024 and Dec 2024
CALL get_revenue_at_risk('Delhi', '2024-01-01', '2024-12-31');