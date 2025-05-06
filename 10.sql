WITH
	d1 AS (
		SELECT
			drink_name
			,date
			,SUM(quantity) AS quantity
		FROM Drinks
		GROUP BY
			1, 2
	)
	,d2 AS (
		SELECT
			date
			,MAX(
				CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END
			) AS hot_cocoa_quantity
			,MAX(
				CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END
			) AS eggnog_quantity
			,MAX(
				CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END
			) AS peppermint_schnapps_quantity
		FROM d1
		GROUP BY
			1
	)
SELECT
	date
FROM d2
WHERE
	hot_cocoa_quantity = 38
	AND eggnog_quantity = 198
	AND peppermint_schnapps_quantity = 298
