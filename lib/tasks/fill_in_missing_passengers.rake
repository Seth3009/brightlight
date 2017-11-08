namespace :data do
	desc "Populate database with missing passengers"
	task fill_in_missing_passengers: :environment do
    records = Transport.joins('left join passengers p on transports.id = p.transport_id')
      .joins('join students s on transports.family_no = s.family_no')
      .joins('join grade_sections_students gss on gss.student_id = s.id and academic_year_id=17')
      .joins('join grade_sections gs on gs.id = gss.grade_section_id')
      .where("transports.category = 'private' AND (p.id is null)")
      .select("transports.id as id, s.id as student_id, transports.family_no, s.name, gs.id as grade_section_id, gs.name as class_name, true as active, 'Additional 2017' as notes")
      .map do |t| {
          transport_id: t.id, 
          student_id: t.student_id, 
          family_no: t.family_no, 
          name: t.name, 
          class_name: t.class_name, 
          grade_section_id: t.grade_section_id, 
          active: t.active, 
          notes: t.notes
        }
      end
    Passenger.create records
  end
end
