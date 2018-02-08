class LeaveRequest < ActiveRecord::Base
  belongs_to :employee
  
  scope :empl, -> (employee_id) { where employee_id: employee_id }
  scope :spv, -> (employee_id) { where('departments.manager_id = ?', employee_id) }
  scope :hrlist, ->  { where('spv_approval = ? or leave_type = ? or leave_type =?','true','Sick', 'Family Matter').where.not('form_submit_date' => nil) }

  def send_for_approval(approver, type)
    if approver      
      if type == 'empl_submit'
        self.update_attributes form_submit_date: Time.now.strftime('%Y-%m-%d')
        EmailNotification.leave_approval(self, approver, type).deliver_now        
      else
        return false
      end
      return true
    end
  end

  def send_approval(employee,approver,status,notes,type)
    if employee && approver
      if type == 'spv-app' || type == 'spv-den'
        self.update_attributes spv_approval: status,spv_notes: notes, spv_date: Time.now.strftime('%Y-%m-%d')
        EmailNotification.leave_spv_approve(self, employee, approver, status, notes,type).deliver_now
      elsif type == 'hr-app' || type == 'hr-den'
        self.update_attributes hr_approval: status, hr_notes: notes, hr_date: Time.now.strftime('%Y-%m-%d')
        EmailNotification.leave_hr_approve(self, employee, approver, status, notes,type).deliver_now
      end
    else
      return false
    end
    return true    
  end
  
end
