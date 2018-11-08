class LeaveRequest < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  belongs_to :employee   
  validates_presence_of :employee_id
  validates_presence_of :start_time, :message => "Start time can't be blank"
  validates_presence_of :end_time, :message => "End time can't be blank"
  validates_presence_of :category, :message => "Choose your leave category"
  validates_presence_of :leave_type, :message => "Choose your leave type"
  validates_presence_of :leave_note, :message => "Describe your leave"
  after_save :fill_hour_column

  acts_as_commentable
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true
  
  scope :active, -> { where(is_canceled: false,employee_canceled: false ) }
  scope :canceled, -> { where(is_canceled: true) }  
  scope :empl_canceled, -> {where(employee_canceled: true)}

  scope :with_employees_and_departments, -> {
    joins('left join employees on employees.id = leave_requests.employee_id') 
    .joins('left join departments on departments.id = employees.department_id')
  }

  scope :empl, -> (employee_id) { where employee_id: employee_id }
  

  scope :spv, -> (employee_id) { 
    submitted
    .where('approver1 = ? or approver2 = ?', employee_id, employee_id)
  }

  scope :spv_archive, -> (employee_id) { 
    submitted
    .where('approver1 = ? or approver2 = ?' , employee_id, employee_id)
    .where("hr_approval is not ? or spv_approval = ? or is_canceled = ? or employee_canceled = ?", nil,false, true, true)  
  }

  scope :hrlist, ->  { 
    where("spv_approval = true")    
  }

  scope :hrlist_archive, ->  { 
    submitted
    .select('leave_requests.*,employees.name as employee_name')
    .archive 
  }

  scope :archive, -> { 
    where("hr_approval is not ? or spv_approval = ? or is_canceled = ? ", nil,false, true)
  }

  scope :submitted, -> { where.not(form_submit_date: nil) }

  scope :draft, -> { where(form_submit_date: nil) }
  
  

  # def auto_approve
  #   if !self.requires_supervisor_approval?
  #     self.update_attributes(:spv_approval => true, :spv_date => Date.today, :spv_notes => "Approval not required")
  #   end
  # end

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
    self.update_attributes is_canceled: true    
    self.save   
    emp = "no"
    if self.employee.approver2.present? && Department.find_by(code: 'HR').vice_manager.present?
      cc = [Employee.find(self.employee.approver1),Employee.find(self.employee.approver2), Department.find_by(code: 'HR').manager,Department.find_by(code: 'HR').vice_manager]
    elsif self.employee.approver2.present? && Department.find_by(code: 'HR').vice_manager.nil?
      cc = [Employee.find(self.employee.approver1),self.Employee.find(self.employee.approver2), Department.find_by(code: 'HR').manager]
    elsif self.employee.approver2.nil? && Department.find_by(code: 'HR').vice_manager.present?
      cc = [Employee.find(self.employee.approver1), Department.find_by(code: 'HR').manager,Department.find_by(code: 'HR').vice_manager]
    else
      cc = [Employee.find(self.employee.approver1), Department.find_by(code: 'HR').manager]
    end
    email = EmailNotification.leave_canceled(self, self.employee, cc, emp).deliver_now    
    notification = Message.new_from_email(email)
    notification.save
  end

  def cancel_by_employee
    self.update_attributes employee_canceled: true
    self.save
    emp = "yes"
    if self.employee.approver2.present?
      cc = [Employee.find(self.employee.approver1),Employee.find(self.employee.approver2)]
    else
      cc = [Employee.find(self.employee.approver1)]
    end
    email = EmailNotification.leave_canceled(self, self.employee, cc, emp).deliver_now
    notification = Message.new_from_email(email)
    notification.save
  end

  def requires_supervisor_approval?
    leave_type == 'Personal Permission' || leave_type == 'School Related Duty' || leave_type == 'Sick' 
  end

  def pending_spv_approval?
    # requires_supervisor_approval? && spv_approval.blank?
    spv_approval.blank?
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

  def fill_hour_column
    if self.leave_day == 1
      @day = " day "
    else
      @day = " days "
    end
    if self.category == 'Early Home' || self.category == 'Come Late'
      @hour = 'Leave time ' +self.start_time.to_s + " to "+ self.end_time.to_s + " (" + time_diff(Time.parse(self.start_time),Time.parse(self.end_time)) + ")" 
    else
      if self.category == "Full Day, Early Home"
        @hour = "Leave date " + self.start_date.strftime('%b %e') + " at " + self.start_time.to_s + ' and full day leave until ' + self.end_date.strftime('%b %e')
      elsif self.category == "Full Day, Come Late"
        @hour = "Full day leave on " + self.start_date.strftime('%b %e') + " and going back late at " + self.end_date.strftime('%b %e') + " (" + self.end_time.to_s + ")"
      elsif self.category == "Full Day"
        @hour = "Leave from " + self.start_date.strftime('%b %e') + " until " + self.end_date.strftime('%b %e')
      else
        @hour = "Leave on " + self.start_date.strftime('%b %e') + " (" + self.start_time.to_s + ") and going back at " + self.end_date.strftime('%b %e') + " (" + self.end_time.to_s + ")"
      end
    end
    self.update_column(:hour,@hour)
  end

  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs
  
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
  
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
  
    seconds = seconds_diff
  
    "#{pluralize(hours.to_s,'hour')} and #{pluralize(minutes.to_s,'minute')}"
    
  end
   # Call back from comment
  def create_email_from_comment(comment)    
    sender = comment.user.employee     
    # Send email to requester and sender, except the comment originator
    addressee = [self.employee, sender].reject {|n| n.id == comment.user.employee.try(:id)}
    to = addressee.map {|e| "#{e.name} <#{e.try(:email)}>"}.join(", ")
    EmailNotification.new_comment_lr comment, to
  end
end
