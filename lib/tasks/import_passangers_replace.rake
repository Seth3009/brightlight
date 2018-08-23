namespace :data do
	desc "Replace shuttle passanger"
	task import_passangers_replace: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/passengers_2018-2019.xlsx')
    sheet = xl.sheet('passengers')

    header = {transport_id:'transport_id',student_id:'student_id',name:'name',family_no:'family_no',grade_section_id:'grade_section_id',class_name:'class_name',active:'active'}
    sheet.each(header) do |row|
      Passenger.where(transport_id:row[:transport_id]).destroy_all
    end
   
        
    sheet.each_with_index(header) do |row,i|
			next if i < 1
      passenger = Passenger.new(
                  transport_id:       row[:transport_id],
                  student_id:   row[:student_id],
                  name:       row[:name],
                  family_no:    row[:family_no],
                  grade_section_id:  row[:grade_section_id],
                  class_name:   row[:class_name],
                  active:     row[:active]
                )
      passenger.save
      puts "#{i}. #{passenger.transport_id} #{passenger.name} #{passenger.class_name}"
    end

    
  end
end
