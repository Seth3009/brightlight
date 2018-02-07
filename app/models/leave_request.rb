class LeaveRequest < ActiveRecord::Base
  belongs_to :employee
  
  scope :empl, -> (employee_id) { where employee_id: employee_id }
  scope :spv, -> (employee_id) { where('departments.manager_id = ?', employee_id) }
  scope :hrlist, ->  { where('spv_approval = ? or leave_type = ? or leave_type =?','true','Sick', 'Family Matter').where.not('form_submit_date' => nil) }

  def send_for_approval(approver, type)
    if approver      
      if type == 'empl_submit'
        self.update_attributes form_submit_date: Time.now.strftime('%Y-%m-%d')              
      elsif type == 'spv-app'
        self.update_attributes spv_approval: true, spv_date: Time.now.strftime('%Y-%m-%d')
      elsif type == 'spv-den'
        self.update_attributes spv_approval: false, spv_date: Time.now.strftime('%Y-%m-%d')
      elsif type == 'hr-app'
        self.update_attributes hr_approval: true, hr_date: Time.now.strftime('%Y-%m-%d')
      elsif type == 'hr-den'
        self.update_attributes hr_approval: false, hr_date: Time.now.strftime('%Y-%m-%d')
      end
      if type == 'empl_submit'
        EmailNotification.leave_approval(self, approver, type).deliver_now  
      else
        EmailNotification.leave_spv_approve(self, approver, type).deliver_now  
      end
    else
      return false
    end
    return true
  end
  
end
