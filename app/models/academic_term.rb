class AcademicTerm < ActiveRecord::Base
	validates :name, presence: true
  belongs_to :academic_year
  has_and_belongs_to_many :courses
  has_many :diknas_conversions


  scope :option_list_from_term, lambda {includes('diknas_conversions').where.not(diknas_conversions: {academic_term_id:nil}).all}
  scope :option_list_to_term, -> { 
    where('academic_year_id >= ?',AcademicYear.current_id)
    .where.not(id: DiknasConversion.pluck(:academic_term_id).reject {|x| x.present?}) 
  }
  scope :list_for_menu, -> (from=7, to=3) { 
    joins(:academic_year)
    .where("academic_years.id >= ? and academic_years.id <= ?", AcademicYear.current_id-from, AcademicYear.current_id+to) 
    .order(:id)
  }

  def short_name
    m = /(Sem).+ (\d) .+/.match(self.name)
    "#{m[1]}. #{m[2]}"
  end

  def number
    /.+ (\d) .+/.match(self.name)[1].to_i
  end
end
