class LeaveRequest < ActiveRecord::Base
  belongs_to :employee
  
  validates_presence_of :hour, :message => "Leave periode can't be blank"
  validates_presence_of :leave_type, :message => "Choose your leave type"
  validates_presence_of :leave_note, :message => "Describe your leave"
  
  
  scope :empl, -> (employee_id) { where employee_id: employee_id }
  scope :spv, -> (employee_id) { where('departments.manager_id = ?', employee_id) }
  scope :hrlist, ->  { where('spv_approval = ? or leave_type = ? or leave_type =?','true','Sick', 'Family Matter').where.not('form_submit_date' => nil) }
  def self.auto_approve(id)
    lr = self.find(id)
    if lr.leave_type == "Sick" || lr.leave_type == "Family Matter"
      lr.update_attributes(:spv_approval => true, :spv_date => Date.today, :spv_notes => "Auto Approve")
    end
  end

  def send_for_approval(approver,sendto, type)
    if approver      
      if type == 'empl_submit'
        self.update_attributes form_submit_date: Time.now.strftime('%Y-%m-%d')
        EmailNotification.leave_approval(self, approver,sendto, type).deliver_now        
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
