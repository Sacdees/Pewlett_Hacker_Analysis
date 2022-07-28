----------------------------------------------DELIVERABLE 1-----------------------------------------

SELECT em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM full_emp as em
	INNER JOIN titles as ti
		ON(em.emp_no = ti.emp_no)
WHERE em.birth_date between '1952-01-01' and '1955-12-31'
ORDER BY em.emp_no;	

SELECT * FROM retirement_titles
------------------- for challenge point-----unique_titles

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date between '9999-01-01' and '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles

--------------------------challenge point----------retiring_titles

SELECT Count (ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
group by ut.title
order by ut.count DESC;

SELECT * FROM retiring_titles

----------------------------------------------DELIVERABLE 2----------------------------------------

SELECT DISTINCT ON (em.emp_no)em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title	
INTO mentorship_data
FROM full_emp as em
	INNER JOIN dept_emp as de
		ON(em.emp_no = de.emp_no)
	INNER JOIN titles as ti
		ON(em.emp_no = ti.emp_no)
WHERE de.to_date between '9999-01-01' and '9999-01-01'
and em.birth_date between '1965-01-01' and '1965-12-31'
ORDER BY em.emp_no;	

SELECT * FROM mentorship_data













