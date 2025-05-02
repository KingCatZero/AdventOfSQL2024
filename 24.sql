SELECT
	song_title
FROM (
	SELECT
		s.song_id
		,s.song_title
		,COUNT(1) AS play_cnt
		,SUM(CASE WHEN up.duration < s.song_duration THEN 1 ELSE 0 END) AS skip_cnt
	FROM user_plays AS up
		INNER JOIN songs AS s ON
			s.song_id = up.song_id
	GROUP BY
		1, 2
) AS t
ORDER BY
	play_cnt DESC
	,skip_cnt ASC
LIMIT 1
