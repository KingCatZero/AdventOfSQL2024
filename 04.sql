WITH
	tp AS (
		SELECT
			toy_id
			,toy_name
			,LIST_FILTER(new_tags, x -> NOT LIST_CONTAINS(previous_tags, x)) AS added_tags
			,LIST_INTERSECT(previous_tags, new_tags) AS unchanged_tags
			,LIST_FILTER(previous_tags, x -> NOT LIST_CONTAINS(new_tags, x)) AS removed_tags
		FROM toy_production
	)
SELECT
	toy_id
	,LEN(added_tags)
	,LEN(unchanged_tags)
	,LEN(removed_tags)
FROM tp
ORDER BY
	2 DESC
LIMIT 1
