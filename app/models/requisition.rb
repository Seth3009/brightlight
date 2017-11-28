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
  
  has_many :req_items, -> { order(:id) }
  accepts_nested_attributes_for :req_items, reject_if: :all_blank, allow_destroy: true

  validates :department, presence: true
  validates :requester, presence: true
  validates :description, presence: true
  validates :req_appvl_notes, presence: true

  def send_to_supv
    self.update_attribute :is_sent_to_supv, true
    EmailNotification.req_supv_approval(self).deliver_now
  end 
end