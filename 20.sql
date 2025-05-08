WITH
	wr1 AS (
		SELECT
			*
			,LIST_UNIQUE(
				LIST_TRANSFORM(
					STRING_SPLIT(SPLIT_PART(url, '?', 2), '&')
					,x -> SPLIT_PART(x, '=', 1)
				)
			) AS param_cnt
		FROM web_requests
		WHERE
			url LIKE '%utm_source=advent-of-sql%'
	)
SELECT
	url
FROM wr1
ORDER BY
	param_cnt DESC
	,url
LIMIT 1
