WITH
	sr AS (
		SELECT
			record_id
			,JSON_EXTRACT_STRING(receipt, 'garment') AS garment
			,JSON_EXTRACT_STRING(receipt, 'color') AS color
			,CAST(JSON_EXTRACT_STRING(receipt, 'drop_off') AS DATE) AS drop_off
		FROM SantaRecords AS sr,
			LATERAL (
				SELECT
					UNNEST(
						FROM_JSON(cleaning_receipts, '["JSON"]')
					) AS receipt
			)
	)
SELECT
	drop_off
FROM sr
WHERE
	garment = 'suit'
	AND color = 'green'
ORDER BY
	1 DESC
LIMIT 1
