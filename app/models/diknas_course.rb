class DiknasCourse < ActiveRecord::Base
  has_many :diknas_conversions


  def self.grade_option(grade)
    case grade
    when 10
      DiknasCourse.select('*,ipa10 as ipa, ips10 as ips')
    when 11
      DiknasCourse.select('*,ipa11 as ipa, ips11 as ips')
    else
      DiknasCourse.select('*,ipa12 as ipa, ips12 as ips')
    end
  end
end
