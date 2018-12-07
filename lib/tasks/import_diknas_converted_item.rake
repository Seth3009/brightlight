namespace :data do
	desc "Import new diknas converted item"
	task import_new_diknas_converted_item: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/DiknasConvertedItem.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {converted_id: 'converted id', conversion_id:'conversion id',np:'np',nt:'nt'}
    # course = Course.find_by_name '2017-2018'

    sheet.each_with_index(header) do |row,i|
        puts "#{i}, #{row}"
		next if i < 1
            
      dc = DiknasConvertedItem.new(
                  diknas_converted_id: row[:converted_id],
                  diknas_conversion_id: row[:conversion_id],
                  P_score: row[:np],
                  T_score: row[:nt],
                )
      dc.save
    #   puts "#{i}. #{student.name} (No:#{student.student_no}/Fam:#{student.family_no})"
    end
  end
end
