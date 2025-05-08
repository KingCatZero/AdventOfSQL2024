WITH
	e1 AS (
		SELECT
			salary
			,LIST_EXTRACT(year_end_performance_scores, -1) AS score
		FROM employees
	)
	,e2 AS (
		SELECT
			*
			,AVG(score) OVER () AS score_avg
		FROM e1
	)
SELECT
	SUM(
		salary
			* CASE
				WHEN score > score_avg THEN 1.15
				ELSE 1.0
			END
	)
FROM e2
