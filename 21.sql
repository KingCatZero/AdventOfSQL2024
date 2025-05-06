WITH
	s1 AS (
		SELECT
			YEAR(sale_date) AS sale_year
			,CAST(((MONTH(sale_date) - 1) / 3) + 1 AS INT) AS sale_quarter
			,SUM(amount) AS amount
		FROM sales
		GROUP BY
			1, 2
	)
	,s2 AS (
		SELECT
			*
			,LAG(amount) OVER (
				ORDER BY
					sale_year, sale_quarter
			) AS amount_prev
		FROM s1
	)
SELECT
	CONCAT(sale_year, ',', sale_quarter)
FROM s2
ORDER BY
	(amount - amount_prev) / amount_prev DESC
LIMIT 1
