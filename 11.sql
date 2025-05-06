WITH
	th1 AS (
		SELECT
			*
			,(harvest_year * 100)
				+ CASE season
					WHEN 'Spring' THEN 1
					WHEN 'Summer' THEN 2
					WHEN 'Fall' THEN 3
					ELSE 4
				END AS harvest_season
		FROM TreeHarvests
	)
	,th2 AS (
		SELECT
			*
			,CAST(
				AVG(trees_harvested) OVER (
					PARTITION BY
						field_name
					ORDER BY
						harvest_season
					ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
				) AS DECIMAL(10, 2)
			) AS three_season_moving_avg
		FROM th1
	)
SELECT
	three_season_moving_avg
FROM th2
ORDER BY
	1 DESC
LIMIT 1
