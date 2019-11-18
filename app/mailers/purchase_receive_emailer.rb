class PurchaseReceiveEmailer < ActionMailer::Base
  default from: "Brightlight <brightlight@cahayabangsa.org>"
  PURCHASING_EMAIL_ADDRESS = Rails.application.config.purchasing_email_address

  def purchase_receive(requisition, po, purchase_receive)
    @requisition = requisition
    @requester = requisition.requester
    @po = po
    @purchase_receive = purchase_receive
    requester_email = %("#{@requester.name}" <#{@requester.email}>)
    mail(to: requester_email, subject: "PO No. #{po.id}. Purchase Receive Notification")
  end

end