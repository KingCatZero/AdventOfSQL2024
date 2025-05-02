SELECT
	string_agg(chr(value), '')
FROM (
	SELECT * FROM letters_a
		UNION ALL
	SELECT * FROM letters_b
) AS t
WHERE
	regexp_matches(chr(value), '[a-zA-Z !"''(),-.:;?]')
