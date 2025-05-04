WITH
	tp AS (
		SELECT
			*
			,LAG(toys_produced) OVER (ORDER BY production_date) AS previous_day_production
		FROM toy_production
	)
SELECT
	*
	,toys_produced - previous_day_production AS production_change
	,CAST(
		(toys_produced - previous_day_production) * 100 / previous_day_production
		AS DECIMAL(10, 2)
	) AS production_change_percentage
FROM tp
ORDER BY
	production_change_percentage DESC
LIMIT 1
