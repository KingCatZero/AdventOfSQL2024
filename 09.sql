WITH
	ts1 AS (
		SELECT
			r.reindeer_name
			,ts.exercise_name
			,AVG(ts.speed_record) AS speed_record_avg
		FROM training_sessions AS ts
			INNER JOIN reindeers AS r ON
				r.reindeer_id = ts.reindeer_id
		WHERE
			r.reindeer_name != 'Rudolph'
		GROUP BY
			r.reindeer_name
			,ts.exercise_name
	)
	,ts2 AS (
		SELECT
			reindeer_name
			,MAX(speed_record_avg) AS speed_record_max
		FROM ts1
		GROUP BY
			reindeer_name
	)
	,ts3 AS (
		SELECT
			*
		FROM ts2
		ORDER BY
			speed_record_max DESC
    LIMIT 3
	)
SELECT
	CONCAT(reindeer_name, ',', CAST(ROUND(speed_record_max, 2) AS DECIMAL(10, 2)))
FROM ts3
ORDER BY
	speed_record_max DESC
