class RequisitionEmailer < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>"

  def approval(requisition, level: 1)
    @requisition = requisition
    @addressee = @requisition.approvals.level(level).map { |approval| %("#{approval.approver.employee.name}" <#{approval.approver.employee.email}>) }
    mail(to: @addressee, subject: "Approval required: Purchase Request #{requisition.id}.")
  end

  def po_processed(requisition, po)
    @requester = requisition.requester
    @requisition = requisition
    @po = po
    mail(to: %("#{@requester.name}" <#{@requester.email}>), subject: "Your purchase request (#{requisition.id}) has been processed.")
  end

  def notify_purchasing(requisition, addressee)
    @requisition = requisition
    @addressee = addressee
    mail(to: addressee, subject: "New Purchase Request #{requisition.id}.")
  end 
end