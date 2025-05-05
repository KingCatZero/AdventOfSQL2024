SELECT
	c.name AS child_name
	,g.name AS gift_name
	,g.price AS gift_price
FROM gifts AS g
	INNER JOIN children AS c ON
		c.child_id = g.child_id
WHERE
	price > (SELECT AVG(price) FROM gifts)
ORDER BY
	3
LIMIT 1
