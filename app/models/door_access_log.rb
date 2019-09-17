class DoorAccessLog < ActiveRecord::Base
  belongs_to :employee
  belongs_to :student
  
  scope :loc_params, lambda { |loc_param|
    if loc_param
      DoorAccessLog.where(location:loc_param)
    else
      DoorAccessLog.all
    end
  }

  scope :for_date, -> date { where(created_at: date.beginning_of_day..date.end_of_day) }

  def self.insert_door_log(person_id,kind,card,location,name)
    if kind == "Employee"
      DoorAccessLog.create(employee_id:person_id, kind:kind, card:card, location:location, name:name)
    else
      DoorAccessLog.create(student_id:person_id, kind:kind, card:card, location:location, name:name)
    end
  end
end
