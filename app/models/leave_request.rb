class LeaveRequest < ActiveRecord::Base
  belongs_to :employee  
  validates_presence_of :employee_id
  validates_presence_of :hour, :message => "Leave period can't be blank"
  validates_presence_of :leave_type, :message => "Choose your leave type"
  validates_presence_of :leave_note, :message => "Describe your leave"
  
  acts_as_commentable
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true
  
  scope :active, -> { where(is_canceled: false) }
  scope :canceled, -> { where(is_canceled: true) }

  scope :with_employees_and_departments, -> {
    joins('left join employees on employees.id = leave_requests.employee_id') 
    .joins('left join departments on departments.id = employees.department_id')
  }

  scope :empl, -> (employee_id) { where employee_id: employee_id }
  

  scope :spv, -> (employee_id) { 
    with_employees_and_departments
    .where('approver1 = ? or approver2 = ?', employee_id, employee_id)
    .order(form_submit_date: :asc, updated_at: :asc)
  }

  scope :spv_archive, -> (employee_id) { 
    with_employees_and_departments
    .where('approver1 = ? or approver2 = ?', employee_id, employee_id)
    .archive
    .order(form_submit_date: :asc, updated_at: :asc)
  }

  scope :hrlist, ->  { 
    submitted
    .active
    .where("spv_approval = true or leave_type = 'Special Leave'")
    .order(spv_date: :asc, form_submit_date: :asc, updated_at: :asc)
  }

  scope :hrlist_archive, ->  { 
    submitted
    .select('leave_requests.*,employees.name as employee_name')
    .archive    
  }

  scope :archive, -> { 
    where("hr_approval is not ?",nil)
  }

  scope :submitted, -> { where.not(form_submit_date: nil) }

  scope :draft, -> { where(form_submit_date: nil) }

  def auto_approve
    if !self.requires_supervisor_approval?
      self.update_attributes(:spv_approval => true, :spv_date => Date.today, :spv_notes => "Approval not required")
    end
  end

  def send_for_approval(supervisor, vice_supervisor, hrmanager, hrvicemanager, sendto, type)
    if supervisor 
      if type == 'empl-submit'   
        self.update_attributes form_submit_date: Time.now.strftime('%Y-%m-%d')
        email = EmailNotification.leave_approval(self, supervisor, vice_supervisor,hrmanager,hrvicemanager, sendto).deliver_now    
        notification = Message.new_from_email(email)
        notification.save
      else
        return false
      end
    else
      return true
    end
  end

  def send_approval(employee,approver,vice_approver, status,notes,type)
    if employee && approver
      if type == 'spv-app' || type == 'spv-den'
        self.update_attributes spv_approval: status,spv_notes: notes, spv_date: Time.now.strftime('%Y-%m-%d')
        email = EmailNotification.leave_spv_approve(self, employee, approver,vice_approver, status, notes,type).deliver_now
        notification = Message.new_from_email(email)
        notification.save
      elsif type == 'hr-app' || type == 'hr-den'
        self.update_attributes hr_approval: status, hr_notes: notes, hr_date: Time.now.strftime('%Y-%m-%d')
        email = EmailNotification.leave_hr_approve(self, employee, approver,vice_approver, status, notes,type).deliver_now
        notification = Message.new_from_email(email)
        notification.save
      end
    else
      return false
    end
    return true    
  end

  def cancel 
    self.is_canceled = true
    self.save
    if self.employee.approver2.present? && Department.find_by(code: 'HR').vice_manager.present?
      cc = [Employee.find(self.employee.approver1),Employee.find(self.employee.approver2), Department.find_by(code: 'HR').manager,Department.find_by(code: 'HR').vice_manager]
    elsif self.employee.approver2.present? && Department.find_by(code: 'HR').vice_manager.nil?
      cc = [Employee.find(self.employee.approver1),self.Employee.find(self.employee.approver2), Department.find_by(code: 'HR').manager]
    elsif self.employee.approver2.nil? && Department.find_by(code: 'HR').vice_manager.present?
      cc = [Employee.find(self.employee.approver1), Department.find_by(code: 'HR').manager,Department.find_by(code: 'HR').vice_manager]
    else
      cc = [Employee.find(self.employee.approver1), Department.find_by(code: 'HR').manager]
    end
    email = EmailNotification.leave_canceled(self, self.employee, cc).deliver_now
    notification = Message.new_from_email(email)
    notification.save
  end

  def requires_supervisor_approval?
    leave_type == 'Personal Permission' || leave_type == 'School Related Duty' || leave_type == 'Sick'
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

  def is_canceled?
    is_canceled
  end

end
