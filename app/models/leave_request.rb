class LeaveRequest < ActiveRecord::Base
  belongs_to :employee
  validates_presence_of :employee_id
  validates_presence_of :hour, :message => "Leave period can't be blank"
  validates_presence_of :leave_type, :message => "Choose your leave type"
  validates_presence_of :leave_note, :message => "Describe your leave"
  
  scope :with_employees_and_departments, -> {
    joins('left join employees on employees.id = leave_requests.employee_id') 
    .joins('left join departments on departments.id = employees.department_id')
  }
  scope :empl, -> (employee_id) { where employee_id: employee_id }
  scope :spv, -> (employee_id) { 
    with_employees_and_departments
    .where('departments.manager_id = ?', employee_id) 
    .order(form_submit_date: :desc)
  }
  scope :hrlist, ->  { 
    submitted
    .where("spv_approval = true or leave_type = 'Sick' or leave_type = 'Family Matter'")
    .order(spv_date: :desc)
  }

  scope :submitted, -> { where.not(form_submit_date: nil) }
  scope :draft, -> { where(form_submit_date: nil) }

  def auto_approve
    if !self.requires_supervisor_approval?
      self.update_attributes(:spv_approval => true, :spv_date => Date.today, :spv_notes => "Approval not required")
    end
  end

  def send_for_approval(approver, sendto, type)
    if approver      
      if type == 'empl_submit'
        self.update_attributes form_submit_date: Time.now.strftime('%Y-%m-%d')
        email = EmailNotification.leave_approval(self, approver, sendto, type).deliver_now    
        notification = Message.new_from_email(email)
        notification.save
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
        email = EmailNotification.leave_spv_approve(self, employee, approver, status, notes,type).deliver_now
        notification = Message.new_from_email(email)
        notification.save
      elsif type == 'hr-app' || type == 'hr-den'
        self.update_attributes hr_approval: status, hr_notes: notes, hr_date: Time.now.strftime('%Y-%m-%d')
        email = EmailNotification.leave_hr_approve(self, employee, approver, status, notes,type).deliver_now
        notification = Message.new_from_email(email)
        notification.save
      end
    else
      return false
    end
    return true    
  end

  def requires_supervisor_approval?
    leave_type == 'Personal' || leave_type == 'School Related'
  end

  def pending_spv_approval?
    requires_supervisor_approval? && spv_approval.blank?
  end

  def pending_hr_approval?
    !pending_spv_approval? && hr_approval.blank?
  end

  def draft?
    !submitted?
  end

  def submitted?
    form_submit_date.present?
  end
end
