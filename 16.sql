WITH
	sl AS (
		SELECT
			place_name
			,ts
			,LEAD(ts) OVER (ORDER BY ts) AS next_ts
		FROM sleigh_locations AS sl
			INNER JOIN areas AS a ON
				a.polygon.STIntersects(sl.coordinate) = 1
	)
SELECT TOP 1
	place_name
FROM sl
GROUP BY
	place_name
ORDER BY
	DATEDIFF(MINUTE, MIN(ts), MAX(next_ts)) DESC
