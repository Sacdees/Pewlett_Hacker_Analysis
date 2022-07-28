SELECT em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retro_titles
FROM emp_info as em
	INNER JOIN titles as ti
		ON(em.emp_no = ti.emp_no)
ORDER BY em.emp_no;	

------------------------------