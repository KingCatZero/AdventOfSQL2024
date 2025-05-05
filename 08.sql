WITH RECURSIVE
	staff_rec AS (
		SELECT
			staff_id
			,staff_name
			,NULL AS manager_id
			,1 AS l
			,CAST('1' AS VARCHAR(1000)) AS p
		FROM staff
		WHERE
			manager_id IS NULL
			
			UNION ALL
			
		SELECT
			s.staff_id
			,s.staff_name
			,s.manager_id
			,sr.l + 1
			,CAST(CONCAT(sr.p, ',', s.staff_id) AS VARCHAR(1000))
		FROM staff AS s
			INNER JOIN staff_rec AS sr ON
				sr.staff_id = s.manager_id
	)
SELECT
	*
FROM staff_rec
ORDER BY
	l DESC
