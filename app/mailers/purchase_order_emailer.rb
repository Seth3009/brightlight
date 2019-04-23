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
end