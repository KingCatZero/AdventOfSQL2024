WITH
	gr1 AS (
		SELECT
			g.gift_name
			,COUNT(1) AS gift_cnt
		FROM gift_requests AS gr
			INNER JOIN gifts AS g ON
				g.gift_id = gr.gift_id
		GROUP BY
			1
	)
	,gr2 AS (
		SELECT
			gift_name
			,CAST(
				PERCENT_RANK() OVER (
					ORDER BY
						gift_cnt
				) AS DECIMAL(3, 2)
			) AS gift_percent_rank
		FROM gr1
	)
	,gr3 AS (
		SELECT
			*
			,DENSE_RANK() OVER (
				ORDER BY
					gift_percent_rank DESC
			) AS gift_rank
		FROM gr2
	)
SELECT
	*
FROM gr3
WHERE
	gift_rank = 2
ORDER BY
	1
LIMIT 1
