class Requisition < ActiveRecord::Base
  belongs_to :department
  belongs_to :requester, class_name: 'Employee'
  belongs_to :supervisor, class_name: 'Employee'
  belongs_to :req_approver, class_name: 'Employee'
  belongs_to :budget_approver, class_name: 'Employee'
  belongs_to :purch_receiver, class_name: 'Employee'
  belongs_to :budget
  belongs_to :budget_item
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'
  
  has_many :req_items, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :req_items, reject_if: :all_blank, allow_destroy: true

  validates :department, presence: true
  validates :requester, presence: true
  validates :description, presence: true

  def send_for_approval(approver, type)
    if approver
      email = EmailNotification.req_approval(self, approver, type)
      email.deliver_now
      notification = Message.new_from_email(email)
      notification.save
      if type == 'supv'
        self.update_attributes sent_to_supv: Date.today, supervisor: approver
      elsif type == 'budget'
        self.update_attributes sent_for_bgt_approval: Date.today
      end
    else
      return false
    end
    return true
  end 
end