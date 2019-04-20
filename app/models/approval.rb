class Approval < ActiveRecord::Base
  belongs_to :approvable, polymorphic: true
  belongs_to :approver

  scope :level, -> (level) { where(level: level).includes(:approver, approver: [:employee]) }
  scope :active, -> { where(active: true) }
  
  def self.new_from_approver(approver)
    self.new level: approver.level, approver_id: approver.id
  end

  def self.new_from_approvers(approvers)
    approvers.map {|approver| self.new_from_approver(approver) }
  end
end
