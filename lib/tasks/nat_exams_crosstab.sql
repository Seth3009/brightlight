--CREATE extension tablefunc;
SELECT * 
FROM crosstab( 
	'SELECT students.name as name, diknas_courses.id as course_id, try_out_2 FROM nat_exams 
	INNER JOIN students ON students.id = nat_exams.student_id
	INNER JOIN diknas_courses ON diknas_courses.id = nat_exams.diknas_course_id
	ORDER BY 1,2',
	'select distinct id from diknas_courses where id in (2,3,6,8,10,11,14,15) order by 1'
	)
AS final_result(name TEXT, "BAHASA INDONESIA" NUMERIC, "BAHASA INGGRIS" NUMERIC, "FISIKA" NUMERIC, "SOSIOLOGI" NUMERIC, "MATEMATIKA" NUMERIC, "BIOLOGI" NUMERIC, "KIMIA" NUMERIC, "EKONOMI" NUMERIC);