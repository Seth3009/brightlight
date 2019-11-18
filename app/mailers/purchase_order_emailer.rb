class PurchaseOrderEmailer < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>"
  PURCHASING_EMAIL_ADDRESS = Rails.application.config.purchasing_email_address

  def notify_requesters(requisition, po)
    @requisition = requisition
    @requester = requisition.requester
    @po = po
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    mail(to: requester_email, subject: "Notification: Purchase Order No. #{po.id}.")
  end

  def open_po(requisition, po)
    @requisition = requisition
    @requester = requisition.requester
    @po = po
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    mail(to: requester_email, subject: "Open Purchase Order No. #{po.id}.")
  end

  def purchase_receive(requisition, po)
    @requisition = requisition
    @requester = requisition.requester
    @po = po
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    mail(to: requester_email, subject: "PO No. #{po.id}. Purchase Receive Notification")
  end

  def cancel_po(requisition, po)
    @requisition = requisition
    @requester = requisition.requester
    @po = po
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    mail(to: requester_email, subject: "Cancel Purchase Order No. #{po.id}.")
  end
end