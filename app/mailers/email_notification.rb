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

  def leave_spv_approve(leave_request, approver, type)
    @employee = approver
    @leave_request = leave_request
    @type = type    
    @dept = Department.find_by_code('HR')
    @hrmanager = Employee.find(@dept.manager_id) 
    if type == 'spv-app'
      mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>),cc: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request #{leave_request.employee.try(:name)}.")
    elsif type == 'spv-den'
      mail(to: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request #{leave_request.employee.try(:name)}.")
    end
  end

  def leave_hr_approve(leave_request, approver, type)
    
  end
end
