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

  def leave_approval(leave_request, approver,vice_approver, sendto, type)
    @approver = approver
    @vice_approver = vice_approver
    @leave_request = leave_request
    @employee = @leave_request.employee
    @sendto = sendto
    @type = type
    @dept = Department.find_by_code('HR')              
    @hrmanager = Employee.find_by_id(@dept.manager_id)
    @hrvicemanager = Employee.find_by_id(@dept.vice_manager_id)
    if @leave_request.leave_type != "Sick" && @leave_request.leave_type != "Special Leave"
      if @vice_approver == "none"
        mail(to: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
      else
        mail(to: %("#{@approver.name}" <#{@approver.email}>, "#{@vice_approver.name}" <#{@vice_approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
      end
    else
      if @hrvicemanager.present? && @vice_approver != "none"
        mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>, "#{@hrvicemanager.name}" <#{@hrvicemanager.email}>), cc: %("#{@approver.name}" <#{@approver.email}>, "#{@vice_approver.name}" <#{@vice_approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
      elsif @hrvicemanager.present? && @vice_approver == "none"
        mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>, "#{@hrvicemanager.name}" <#{@hrvicemanager.email}>), cc: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
      elsif @hrvicemanager.nil? && @vice_approver != "none"
        mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@approver.name}" <#{@approver.email}>, "#{@vice_approver.name}" <#{@vice_approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
      else
        mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Leave Request #{leave_request.employee.try(:name)}.")
      end
    end
  end 

  def leave_spv_approve(leave_request, employee, hrmanager, status, notes, type)
    @employee = employee
    @hrmanager = hrmanager
    @leave_request = leave_request
    @type = type        
    if type == 'spv-app'
      mail(to: %("#{@hrmanager.name}" <#{@hrmanager.email}>), cc: %("#{@employee.name}" <#{@employee.email}>), subject: "[SPV] Leave Request Approved: #{leave_request.employee.try(:name)}.")
    elsif type == 'spv-den'
      mail(to: %("#{@employee.name}" <#{@employee.email}>), subject: "[SPV] Leave canceled: #{leave_request.employee.try(:name)}.")
    end
  end

  def leave_hr_approve(leave_request, employee, supervisor, status, notes, type)
    @supervisor = supervisor
    @leave_request = leave_request
    @type = type
    @employee = Employee.find_by_id(leave_request.employee_id)
    if type == 'hr-app'
      @subject = "[HRD] Leave Request Approved: #{leave_request.employee.try(:name)}."
    elsif type == 'hr-den'
      @subject = "[HRD] Leave Request Canceled: #{leave_request.employee.try(:name)}."
    end
      mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: %("#{@supervisor.name}" <#{@supervisor.email}>), subject: @subject)

  end

  def leave_canceled(leave_request, employee, cc_list)
    @employee = employee
    @leave_request = leave_request
    cc = cc_list.map {|e| "#{e.name} <#{e.try(:email)}>"}.join(", ")
    mail(to: %("#{@employee.name}" <#{@employee.email}>), cc: cc, subject: "Leave canceled (#{employee.name})")
  end
end
