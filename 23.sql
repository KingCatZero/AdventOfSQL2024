WITH
	st1 AS (
		SELECT
			id
			,LEAD(id) OVER (ORDER BY id) AS next_id
		FROM sequence_table
	)
	,st2 AS (
		SELECT
			id + 1 AS gap_start
			,next_id - 1 AS gap_end
		FROM st1
		WHERE
			id < next_id - 1
	)
SELECT
	gap_start
	,gap_end
	,STRING_AGG(n)
FROM st2,
	LATERAL (
		SELECT
			generate_series AS n
		FROM GENERATE_SERIES(gap_start, gap_end)
	)
GROUP BY
	1, 2
ORDER BY
	gap_start
