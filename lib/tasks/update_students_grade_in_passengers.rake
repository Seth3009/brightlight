namespace :data do
  desc "Update students' grade in passengers"
  task update_students_grade_in_passengers: :environment do
    passengers_with_grades = Passenger.
      joins('join grade_sections_students gss on passengers.student_id = gss.student_id and gss.academic_year_id=19').
      joins('left join grade_sections gs on gs.id = gss.grade_section_id').
      joins('join students s on s.id = passengers.student_id').
      select('passengers.*, gs.id as gsid, gs.name as gsname')

    passengers_with_grades.each do |pax|
      pax.grade_section_id = pax.gsid
      pax.class_name = pax.gsname
      pax.save
      puts "#{pax.name} #{pax.class_name} => #{pax.gsname}" 
    end
  end
end
