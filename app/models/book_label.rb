# Book Labels are in the form of GradeSection.name#number, such as '1A#12' or '12C#3'
class BookLabel < ActiveRecord::Base
  belongs_to :grade_level
  belongs_to :grade_section
  belongs_to :student
  has_many   :book_copies
  
  validates :name, presence: true, uniqueness: true

  def self.for_name(name)
    where(name:name).first
  end

  def self.for_section_and_number(section, number)
    label = section + '#' + number.to_s
    where(name:label).first
  end

  def self.for_section(section)
    where('name LIKE ?', "#{section}%")
  end

  def section_name
    name.match(/\d+[A-Z]/).to_s
  end

  def self.for_select
    [[ "None", [["--", nil]]]] +
    GradeSection.joins(:book_labels).includes(:book_labels).order(:id).map {|gs| 
      [ gs.name, gs.book_labels.map {|lbl| [lbl.name, lbl.id] } ]
    }
  end
end
