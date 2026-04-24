WITH demand AS (

    SELECT
        dr.recipient_blood_group,
        SUM(units_required) AS total_demand_units
    FROM analytics.fact_blood_requests r
	JOIN analytics.dim_recipients dr
		ON dr.recipient_id=r.recipient_id
	WHERE r.request_status='active'
    GROUP BY dr.recipient_blood_group
),

supply AS (

    SELECT
        i.blood_group,
        SUM(i.units_available) AS total_supply_units

    FROM analytics.fact_blood_inventory i
    WHERE i.status IN ('stored','tested')
	AND i.quality='Good'
    GROUP BY i.blood_group
)

SELECT
    d.recipient_blood_group,
    d.total_demand_units,
    COALESCE(s.total_supply_units, 0) AS total_supply_units,
    (COALESCE(s.total_supply_units, 0) - d.total_demand_units) AS gap,
    CASE
        WHEN COALESCE(s.total_supply_units, 0) >= d.total_demand_units
            THEN 'sufficient'
        ELSE 'shortage'
    END AS status

FROM demand d
LEFT JOIN supply s
    ON d.recipient_blood_group = s.blood_group

ORDER BY d.recipient_blood_group;