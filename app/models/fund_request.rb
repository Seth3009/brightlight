class FundRequest < ActiveRecord::Base

  scope :submitted, -> { where(is_submitted: true) }

  scope :draft, -> { where(is_submitted: false) }

  def draft?
    !submitted?
  end

  def submitted?
    is_submitted = true
  end
end
