namespace :data do
	desc "update passengers"
	task update_passengers: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/passengers2018-2019.xlsx')
    sheet = xl.sheet('part1')

    header = {id:'id',transport_id:'transport_id',student_id:'student_id',grade_section_id:'grade_section_id',class_name:'class_name'}
    # sheet.each(header) do |row|
    #   Passenger.where(id:row[:id]).destroy_all
    # end
   
        
    sheet.each_with_index(header) do |row,i|
			next if i < 1		
      passenger = Passenger.find(row[:id])
      passenger.update(                  
                  grade_section_id:  row[:grade_section_id],
                  class_name:   row[:class_name]                  
                )        
      puts "#{passenger.id} #{passenger.name} #{passenger.class_name}"
    end 
  end
end
