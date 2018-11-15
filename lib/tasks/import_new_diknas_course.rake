namespace :data do
	desc "Import new diknas course"
	task import_new_diknas_course: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/diknascourses.xlsx')
    sheet = xl.sheet('Sheet1')

    header = {no:'no',name:'name',notes:'notes'}

    sheet.each_with_index(header) do |row,i|
			next if i < 1
    
      diknascourse = DiknasCourse.new(
                  name: row[:name],
                  notes: row[:notes]                  
                )
      diknascourse.save
    end
  end
end
