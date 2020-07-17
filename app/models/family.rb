class Family < ActiveRecord::Base
  has_many :family_members, dependent: :restrict_with_error
  validates :family_number, uniqueness: true
  validates :family_no, uniqueness: true

  def guardians               # Hey, we can't use 'parents' here. :parents is a method name in Ruby  
    family_members.guardians.includes(:guardian).map &:guardian
  end 

  def father
    family_members.father.take.guardian
  end 

  def mother
    family_members.mother.take.guardian
  end 

  def children 
    family_members.children.includes(:student).map &:student
  end

  def find_or_create_relation (relation)
    family_members.find_or_create_by relation:relation
  end

  def update_guardian(relation, attributes)
    family_relation = find_or_create_relation relation.to_s
    guardian = family_relation.guardian

    # Name is the least reliable attributes to search by,
    # so, we search by email first, and then by name
    guardian = Guardian.for_email_and_family(attributes[:email], attributes[:family_id]) if guardian.blank?
    guardian = Guardian.for_name_and_family(attributes[:name], attributes[:family_id]) if guardian.blank?
    guardian = Guardian.new if guardian.blank?

    guardian.attributes = attributes
    guardian.save
    family_relation.guardian_id = guardian.id
    family_relation.save
  end

  def update_child(student)
    relation = family_members.find_by student: student, relation: 'child'
    unless relation.present?
      family_members << FamilyMember.create(relation:'child', student: student)
    end
  end
end
