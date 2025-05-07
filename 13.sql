WITH
	cl1 AS (
		SELECT
			UNNEST(email_addresses) AS email_address
		FROM contact_list AS cl
	)
	,cl2 AS (
		SELECT
			*
			,POSITION('@' IN email_address) AS i
		FROM cl1
	)
	,cl3 AS (
		SELECT
			SUBSTRING(email_address, i + 1, LEN(email_address) - i) AS domain
			,COUNT(1) AS cnt
		FROM cl2
		GROUP BY
			1
	)
SELECT
	*
FROM cl3
ORDER BY
	2 DESC
LIMIT 1
