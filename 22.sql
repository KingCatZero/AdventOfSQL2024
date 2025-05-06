WITH
	e1 AS (
		SELECT
			*
			,ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS id
		FROM elves
	)
	,e2 AS (
		SELECT
			id
			,unnest(split(skills, ',')) AS skill
		FROM e1
	)
SELECT
	COUNT(1)
FROM e2
WHERE
	skill = 'SQL'
