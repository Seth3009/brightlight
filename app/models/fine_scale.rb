class FineScale < ActiveRecord::Base
  belongs_to :old_condition, class_name: 'BookCondition'
  belongs_to :new_condition, class_name: 'BookCondition'

  def self.fine_percentage_for_condition_change(old, new)
    FineScale.where(old_condition:old).where(new_condition:new).pluck(:percentage).first || 0.0
  end

  def percent_format
    "#{percentage*100}%"
  end

  def self.collection_for_select
    all.collect{|f| [f.percent_format,f.percentage]}.uniq.sort{|a,b| b[1] <=> a[1]}
  end
end
