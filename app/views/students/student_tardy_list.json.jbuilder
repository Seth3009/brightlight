json.array!(@students) do |student|
    json.id            student.id
    json.name          student.name
    json.grade_section student.grade_section_id
    json.grade         student.grade
    json.family_no     student.family_no
    json.roster_no     student.order_no 
    json.homeroom_id    student.homeroom_id
    json.homeroom       student.homeroom   
end
