namespace :data do
	desc "Import new employees"
	task import_new_employees: :environment do

    xl = Roo::Spreadsheet.open('lib/tasks/new employees 2017-2018.xlsx')
    sheet = xl.sheet('employees')

    header = {name:'name',
            first_name:'first_name',
            last_name:'last_name',
            gender:'gender',
            date_of_birth:'date_of_birth',
            place_of_birth:'place_of_birth',
            joining_date:'joining_date',
            job_title:'job_title',
            employee_number:'employee_number',
            marital_status:'marital_status',
            employment_status:'employment_status',
            supervisor_id:'supervisor_id',
            department_id:'department_id',
            blood_type:'blood_type',
            is_active:'is_active'
            }

    sheet.each_with_index(header) do |row,i|
			next if i < 1
      employee = Employee.new(
                name: row[:name],
                first_name: row[:first_name],
                last_name: row[:last_name],
                gender: row[:gender],
                date_of_birth: row[:date_of_birth],
                place_of_birth: row[:place_of_birth],
                joining_date: row[:joining_date],
                job_title: row[:job_title],
                employee_number: row[:employee_number],
                marital_status: row[:marital_status],
                employment_status: row[:employment_status],
                supervisor_id: row[:supervisor_id],
                department_id: row[:department_id],
                blood_type: row[:blood_type],
                is_active: row[:is_active]
                )
      employee.save
      puts "#{i}. #{employee.name} (#{employee.gender}) (No:#{employee.employee_number})"
    end
  end
end
