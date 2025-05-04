WITH
	wl1 AS (
		SELECT
			child_id
			,json_extract_string(
				wishes
				,['first_choice', 'second_choice', 'colors']
			) AS wishes
		FROM wish_lists
	)
	,wl2 AS (
		SELECT
			child_id
			,wishes[1] AS primary_wish
			,wishes[2] AS backup_wish
			,from_json(json(wishes[3]), '["VARCHAR"]') AS colors
		FROM wl1
	)
SELECT
	CONCAT(
		c.name
		,','
		,wl2.primary_wish
		,','
		,wl2.backup_wish
		,','
		,colors[1]
		,','
		,LEN(colors)
		,','
		,CASE
			WHEN tc1.difficulty_to_make = 1 THEN 'Simple Gift'
			WHEN tc1.difficulty_to_make = 2 THEN 'Moderate Gift'
			ELSE 'Complex Gift'
		END
		,','
		,CASE
			WHEN tc1.category = 'outdoor' THEN 'Outside Workshop'
			WHEN tc1.category = 'educational' THEN 'Learning Workshop'
			ELSE 'General Workshop'
		END
	)
FROM wl2
	INNER JOIN children AS c ON
		c.child_id = wl2.child_id
	INNER JOIN toy_catalogue AS tc1 ON
		tc1.toy_name = wl2.primary_wish
	INNER JOIN toy_catalogue AS tc2 ON
		tc2.toy_name = wl2.backup_wish
ORDER BY
	1
LIMIT 5
