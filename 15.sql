DECLARE @p GEOGRAPHY = (
	SELECT TOP 1
		coordinate
	FROM sleigh_locations
	ORDER BY
		ts DESC
);

SELECT
	place_name
FROM areas
WHERE
	polygon.STIntersects(@p) = 1
