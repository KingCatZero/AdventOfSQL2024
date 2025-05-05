WITH
	we1 AS (
		SELECT
			*
			,MAX_BY(elf_id, years_experience) OVER (
				PARTITION BY
					primary_skill
			) AS elf_1_id
			,MIN_BY(elf_id, years_experience) OVER (
				PARTITION BY
					primary_skill
			) AS elf_2_id
		FROM workshop_elves
	)
	,we2 AS (
		SELECT DISTINCT
			elf_1_id
			,elf_2_id
			,primary_skill
		FROM we1
	)
SELECT
	CONCAT(
		elf_1_id
		,','
		,elf_2_id
		,','
		,primary_skill
	)
FROM we2
ORDER BY
	elf_1_id
	,elf_2_id
