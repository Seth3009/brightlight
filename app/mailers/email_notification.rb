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
    mail(to: %("#{@approver.name}" <#{@approver.email}>), subject: "Approval required: Purchase Request #{leave_request.form_submit_date}.")
  end 
end
