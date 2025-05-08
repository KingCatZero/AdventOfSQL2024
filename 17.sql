WITH
	w AS (
		SELECT
			workshop_name
			,timezone
			,('1900-01-01 ' || business_start_time || ' ' || timezone) :: timestamptz AS business_start_time
			,('1900-01-01 ' || business_end_time || ' ' || timezone) :: timestamptz AS business_end_time
		FROM Workshops
	)
SELECT
	SUBSTRING(CAST(MAX(business_start_time) AS VARCHAR(100)), 12, 8)
FROM w
