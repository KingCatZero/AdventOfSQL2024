WITH
	cm1 AS (
		SELECT
			*
		FROM christmas_menus
		WHERE
			COALESCE(
				menu_data.value('(//total_guests)[1]', 'int')
				,menu_data.value('(//total_count)[1]', 'int')
				,menu_data.value('(//total_present)[1]', 'int')
			) > 78
	)
	,cm2 AS (
		SELECT
			md.c.query('.').value('(//food_item_id)[1]', 'int') AS food_item_id
		FROM cm1
			CROSS APPLY menu_data.nodes('//food_item_id') AS md(c)
	)
SELECT TOP 1
	food_item_id
FROM cm2
GROUP BY
	food_item_id
ORDER BY
	COUNT(1) DESC
