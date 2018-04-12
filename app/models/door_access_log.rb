class DoorAccessLog < ActiveRecord::Base
  belongs_to :employee
  belongs_to :student

  def self.insert_door_log(person_id,kind,card,location,name)
    if kind == "Employee"
      DoorAccessLog.create(employee_id:person_id, kind:kind, card:card, location:location, name:name)
    else
      DoorAccessLog.create(student_id:person_id, kind:kind, card:card, location:location, name:name)
    end
  end
end
