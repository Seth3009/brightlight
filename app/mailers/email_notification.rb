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

  def leave_approval(leave_request, approver, sendto, type)
    @approver = approver
    @leave_request = leave_request
    @employee = @leave_request.employee
    @sendto = sendto
    @type = type
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id)
    if @leave_request.leave_type != "Sick" && @leave_request.leave_type != "Family Matter"
      mail(to: %("#{@approver.name}" <#{@approver.email}>), cc: %("#{@employee.name}" <#{@employee.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
    else
      mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@approver.name}" <#{@approver.email}>, "#{@employee.name}" <#{@employee.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
    end
  end 

  def leave_spv_approve(leave_request, employee, hrmanager, status, notes, type)
    @employee = employee
    @hrmanager = hrmanager
    @leave_request = leave_request
    @type = type        
    if type == 'spv-app'
      mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request #{leave_request.employee.try(:name)}.")
    elsif type == 'spv-den'
      mail(to: %("#{@employee.name}" <#{@employee.email}>), subject: "Leave Request #{leave_request.employee.try(:name)}.")
    end
  end

  def leave_hr_approve(leave_request, employee, supervisor, status, notes, type)
    @supervisor = supervisor
    @leave_request = leave_request
    @type = type
    @employee = Employee.find_by_id(leave_request.employee_id)
    mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
  end
end
