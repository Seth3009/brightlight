class LeaveRequest < ActiveRecord::Base
  belongs_to :employee
  
  scope :empl, -> (employee_id) { where employee_id: employee_id }
  scope :spv, -> (employee_id) { where('departments.manager_id = ?', employee_id) }
  scope :hrlist, ->  { where('spv_approval = ? or leave_type = ? or leave_type =?','true','Sick', 'Family Matter').where.not('form_submit_date' => nil) }

  def self.show_by_type  
      self.joins('left join employees on employees.id = leave_requests.employee_id') 
          .joins('left join departments on departments.id = employees.department_id')    
  end
  
end
