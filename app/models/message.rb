class Message < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :parent, class_name: "Message"
  belongs_to :remind_frequency
  belongs_to :msg_folder

  has_many :message_recipients, dependent: :destroy
  has_one  :reminder, dependent: :destroy

  scope :unread, lambda { |user| joins(:message_recipients).where(message_recipients: {recipient_id: user.id, is_read: false}) }
  
  def self.create_new(to, from, subject, body, cc = [], bcc = [])
    msg = Message.new subject:subject, body:body, creator: from
    msg.message_recipients << to.map  {|r| MessageRecipient.new(recipient_id: r.id, recipient_type: 'to')}
    msg.message_recipients << cc.map  {|r| MessageRecipient.new(recipient_id: r.id, recipient_type: 'cc')}
    msg.message_recipients << bcc.map {|r| MessageRecipient.new(recipient_id: r.id, recipient_type: 'bcc')}
    msg.save
  end 

  def self.new_from_email(email)
    html = Nokogiri::HTML(email.body.to_s)
    body = html.search('//body').to_s
    message = Message.new subject: email.subject, creator: User.find_by_email(email.from), body: body
    if email.to
      email.to.each do |address|
        recipient = User.find_by_email(address)
        if recipient.present?
          message.message_recipients << MessageRecipient.new(recipient: recipient, recipient_type:'to')
        end
      end
    end
    if email.cc
      email.cc.each do |address|
        recipient = User.find_by_email(address)
        if recipient.present?
          message.message_recipients << MessageRecipient.new(recipient: recipient, recipient_type:'cc')
        end
      end
    end
    if email.bcc
      email.bcc.each do |address|
        recipient = User.find_by_email(address)
        if recipient.present?
          message.message_recipients << MessageRecipient.new(recipient: recipient, recipient_type:'bcc')
        end
      end
    end
    message 
  end

  def reply(reply_message)
    reply_message.parent = self
    reply_message.subject = "RE: #{self.subject}"
    unless reply_message.recipients_include? self.creator
      reply_message.message_recipients << MessageRecipient.new(recipient_id: self.creator_id, recipient_type: 'to')
    end
    reply_message.save
  end

  def replies 
    Message.where(parent: self)
  end

  def recipients_include?(addressee)
    case
    when addressee.class == MessageRecipient
      self.message_recipients.to_a.include? addressee
    when addressee.class == User
      self.message_recipients.map(&:recipient).include? addressee
    when addressee.class == Fixnum
      self.message_recipients.map(&:recipient_id).include? addressee
    else false
    end
  end

  def recipient_names_for_type(type)
    self.message_recipients.where(recipient_type: type).map {|r| r.recipient.name}.join(', ')
  end

end