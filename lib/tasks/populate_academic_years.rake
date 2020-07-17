namespace :db do
	desc "Populate database with AcademicYear"
	task populate_academic_years: :environment do
		require 'populator'

		# Academic Years and Terms
		year = 2000 + AcademicYear.last.id
		AcademicYear.populate 9 do |acad_year|
			year += 1
			acad_year.name = "#{year}-#{year+1}"
			acad_year.start_date = Date.new(year, 7, 1)
			acad_year.end_date = Date.new(year+1, 6, 30)

			t = 1
			AcademicTerm.populate 1 do |term|
				term.name = "Semester #{t} #{acad_year.name}"
				term.start_date = acad_year.start_date
				term.end_date = Date.new(year, 12, 31)
				term.academic_year_id = acad_year.id
			end
			t += 1
			AcademicTerm.populate 1 do |term|
				term.name = "Semester #{t} #{acad_year.name}"
				term.start_date = Date.new(year+1, 1, 1)
				term.end_date = acad_year.end_date
				term.academic_year_id = acad_year.id
			end
		end
  end
end
