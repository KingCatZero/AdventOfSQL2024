WITH RECURSIVE
	staff_rec AS (
		SELECT
			staff_id
			,1 AS level
		FROM staff
		WHERE
			manager_id IS NULL
			
			UNION ALL
			
		SELECT
			s.staff_id
			,sr.level + 1
		FROM staff AS s
			INNER JOIN staff_rec AS sr ON
				sr.staff_id = s.manager_id
	)
	,staff_agg AS (
		SELECT
			*
			,COUNT(1) OVER (
				PARTITION BY
					level
			) AS level_cnt
		FROM staff_rec
	)
SELECT
	*
FROM staff_agg
ORDER BY
	level_cnt DESC
	,staff_id
limit 1
