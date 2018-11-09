class EmailNotification < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>",
          bcc: "medhiwidjaja@cahayabangsa.org"

  def scan_completed(user)
    @user = user
    mail(to: %("#{@user.name}" <#{@user.email}>), subject: 'Book scan completed.')
  end 

  def req_approval(requisition, approver, type)
    @approver = approver
    @requisition = requisition
    @type = type
    mail(to: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Purchase Request #{requisition.id}.")
  end 

  def requisition_to_purchasing(requisition, addressee)
    @requisition = requisition
    @addressee = addressee
    mail(to: addressee, subject: "New Purchase Request #{requisition.id}.")
  end 

  def leave_approval(leave_request, supervisor,vice_supervisor,hrmanager,hrvicemanager, sendto)
    @supervisor = Employee.find_by_id(supervisor)
    @vice_supervisor = Employee.find_by_id(vice_supervisor)
    @hrmanager = Employee.find_by_id(hrmanager)
    @hrvicemanager = Employee.find_by_id(hrvicemanager)
    @leave_request = leave_request
    @employee = @leave_request.employee
    @sendto = sendto    
    if @sendto == "spv"
      if @vice_supervisor.nil?
        mail(to: %("#{@supervisor.name}" <#{@supervisor.email}>), subject: "Supervisor approval required: Leave Request #{leave_request.employee.try(:name)}.")
      else
        mail(to: %("#{@supervisor.name}" <#{@supervisor.email}>, "#{@vice_supervisor.name}" <#{@vice_supervisor.email}>), subject: "Supervisor approval required: Leave Request #{leave_request.employee.try(:name)}.")
      end
    elsif @sendto == "hr"
        if @hrvicemanager.present? && @vice_supervisor.present?
          mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>, "#{@hrvicemanager.name}" <#{@hrvicemanager.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>, "#{@vice_supervisor.name}" <#{@vice_supervisor.email}>), subject: "HR approval required: Leave Request #{leave_request.employee.try(:name)}.")
        elsif @hrvicemanager.nil? && @vice_approver.present?
          mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>, "#{@vice_supervisor.name}" <#{@vice_supervisor.email}>), subject: "HR approval required: Leave Request #{leave_request.employee.try(:name)}.")
        elsif @hrvicemanager.present? && @vice_approver.nil?
          mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>, "#{@hrvicemanager.name}" <#{@hrvicemanager.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>), subject: "HR approval required: Leave Request #{leave_request.employee.try(:name)}.")
        else
          mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>), subject: "HR approval required: Leave Request #{leave_request.employee.try(:name)}.")
        end
    else
      redirect_to leave_requests_url, alert: "unavailable page"
    end
  end 

  def leave_spv_approve(leave_request, employee, hrmanager,hrvicemanager, status, notes, type)
    @employee = employee
    @hrmanager = hrmanager
    @hrvicemanager = hrvicemanager
    @leave_request = leave_request
    @type = type        
    if type == 'spv-app'
      if @hrvicemanager.present?
        mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>, "#{@hrvicemanager.name}" <#{@hrvicemanager.email}>), subject: "[SPV] Leave Request Approved: #{leave_request.employee.try(:name)}.")
      else
        mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), subject: "[SPV] Leave Request Approved: #{leave_request.employee.try(:name)}.")
      end
    elsif type == 'spv-den'
      mail(to: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request Not Approved: #{leave_request.employee.try(:name)}.")
    end
  end

  def leave_hr_approve(leave_request, employee, approver, vice_approver, status, notes, type)
    @supervisor = approver
    @vice_supervisor = vice_approver
    @leave_request = leave_request
    @type = type
    @employee = Employee.find_by_id(leave_request.employee_id)
    if type == 'hr-app'
      @subject = "Leave Request Approved: #{leave_request.employee.try(:name)}."
    elsif type == 'hr-den'
      @subject = "Leave Request Not Approved: #{leave_request.employee.try(:name)}."
    end
    if @vice_supervisor.present?
      mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>, "#{@vice_supervisor.name}" <#{@vice_supervisor.email}>), subject: @subject)
    else
      mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>), subject: @subject)
    end
  end

  def leave_canceled(leave_request, employee, cc_list, emp)
    @emp = emp
    @employee = employee
    @leave_request = leave_request
    cc = cc_list.map {|e| "#{e.name} <#{e.try(:email)}>"}.join(", ")
    if @emp == "yes"
      mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: cc, subject: "Leave canceled by employee")
    else
      mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: cc, subject: "Leave canceled by HR (#{employee.name})")
    end
  end

  def new_comment(comment, addressee)
    @comment = comment 
    @from = @comment.user 
    @to = addressee
    mail(to: @to, subject: "New comment on #{comment.commentable.description}")
  end

  def new_comment_lr(comment, addressee)
    @comment = comment 
    @from = @comment.user 
    @to = addressee
    mail(to: @to, subject: "New comment on #{comment.commentable.leave_type}")
  end
end
