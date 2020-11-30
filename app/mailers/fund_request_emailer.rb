class FundRequestEmailer < ApplicationMailer
  default from: "Brightlight <brightlight@cahayabangsa.org>"
  FINANCE_EMAIL_ADDRESS = Rails.application.config.finance_email_address

  def approval(fund_request, approvers)
    @fund_request = fund_request
    @requester = fund_request.requester
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    @addressee = approvers.map { |approval| %("#{approval.approver.employee.name}" <#{approval.approver.employee.email}>) }
    mail(to: @addressee, cc: requester_email, subject: "Approval required: Purchase Request No. #{fund_request.id}.")
  end

  def not_approved(fund_request, level:)
    @fund_request = fund_request
    @requester = requisition.requester
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    approvers = @fund_request.approvals.level(level)
    approvers_emails = approvers.map { |approval| %("#{approval.approver.employee.name}" <#{approval.approver.employee.email}>) }
    mail(to: requester_email,cc: approvers_emails, subject: "Fund Request No. #{fund_request.id} is not approved.")
  end

  def fund_request_to_finance(fund_request)
    @fund_request = fund_request
    requester = fund_request.requester
    requester_email = %("#{requester.name}" <#{requester.email}>)
    mail(to: FINANCE_EMAIL_ADDRESS, cc: requester_email, subject: "Fund Request No. #{fund_request.id} submitted")
  end 

  def reminder_for_finance(fund_request)
    @fund_request = fund_request
    requester = fund_request.requester
    requester_email = %("#{requester.name}" <#{requester.email}>)
    mail(to: FINANCE_EMAIL_ADDRESS, cc: requester_email, subject: "Overdue Reminder for Fund Request No. #{fund_request.id}")
  end
end
