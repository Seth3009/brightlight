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
    mail(to: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Purchase Request #{requisition.req_no}.")
  end 

  def leave_approval(leave_request, approver, type)
    @approver = approver
    @leave_request = leave_request
    @type = type
    mail(to: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
  end 

  def leave_spv_approve(leave_request, employee, approver, status, notes, type)
    @employee = employee
    @hrmanager = approver
    @leave_request = leave_request
    @type = type        
    if type == 'spv-app'
      mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>),cc: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request #{leave_request.employee.try(:name)}.")
    elsif type == 'spv-den'
      mail(to: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request #{leave_request.employee.try(:name)}.")
    end
  end

  def leave_hr_approve(leave_request, employee, approver, status, notes, type)
    @approver = approver
    @leave_request = leave_request
    @type = type
    @employee = Employee.find_by_id(leave_request.employee_id)
    mail(to: %("#{@employee.name}" <#{@employee.email}>),cc: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
  end
end
