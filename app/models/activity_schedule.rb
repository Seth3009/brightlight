class ActivitySchedule < ActiveRecord::Base
  has_many :student_activities, :dependent => :destroy
  has_many :students, through: :student_activities

  belongs_to :academic_year
  validates :activity, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  accepts_nested_attributes_for :student_activities, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :students

  
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
    .where('start_date <= ? AND end_date >= ?',Date.today,Date.today)
  }

  scope :permit_for_badge_id, lambda { |id|
    joins('left join student_activities on student_activities.activity_schedule_id = activity_schedules.id')
    .joins('left join students on students.id = student_activities.student_id')
    .joins('left join badges on badges.student_id = students.id')
    .select('students.name, badges.code, badges.student_id, badges.kind, activity_schedules.academic_year_id')
    .where(is_active:true)
    .where(badges: {id: id}).first 
  }
end
