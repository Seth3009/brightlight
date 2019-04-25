class RequisitionEmailer < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>"
  PURCHASING_EMAIL_ADDRESS = Rails.application.config.purchasing_email_address

  def approval(requisition, approvers)
    @requisition = requisition
    @requester = requisition.requester
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    @addressee = approvers.map { |approval| %("#{approval.approver.employee.name}" <#{approval.approver.employee.email}>) }
    mail(to: @addressee, cc: requester_email, subject: "Approval required: Purchase Request No. #{requisition.id}.")
  end

  def po_processed(requisition, po)
    @requester = requisition.requester
    @requester_email = %("#{@requester.name}" <#{@requester.email}>)
    @requisition = requisition
    @po = po
    mail(to: requester_email, subject: "Your purchase request No. #{requisition.id} has been processed.")
  end

  def not_approved(requisition, level:)
    @requisition = requisition
    @requester = requisition.requester
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    approvers = @requisition.approvals.level(level)
    approvers_emails = approvers.map { |approval| %("#{approval.approver.employee.name}" <#{approval.approver.employee.email}>) }
    mail(to: requester_email,cc: approvers_emails, subject: "Purchase Request No. #{requisition.id} is not approved.")
  end

  def requisition_to_purchasing(requisition)
    @requisition = requisition
    requester = requisition.requester
    requester_email = %("#{requester.name}" <#{requester.email}>)
    mail(to: PURCHASING_EMAIL_ADDRESS, cc: requester_email, subject: "Purchase Request No. #{requisition.id} submitted")
  end 
end