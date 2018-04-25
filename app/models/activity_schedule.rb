class ActivitySchedule < ActiveRecord::Base
  has_many :students, through: :student_activities


  scope :filter_day, lambda {
    where(academic_year_id:AcademicYear.current_id)
    case Time.now.strftime("%a")
    when "Sun"
      where('sun_start <= ? AND sun_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))  
    when "Mon"
      where('mon_start <= ? AND mon_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))
    when "Tue"
      where('tue_start <= ? AND tue_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))
    when "Wed"
      where('wed_start <= ? AND wed_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))
    when "Thu"
      where('thu_start <= ? AND thu_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))
    when "Fri"
      where('fri_start <= ? AND fri_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))
    else
      where('sat_start <= ? AND sat_end >= ?',Time.now.strftime("%R"),Time.now.strftime("%R"))
    end
  }
end
