class DiknasConverted < ActiveRecord::Base
  belongs_to :student
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level

  has_many :diknas_converted_items, dependent: :destroy
  accepts_nested_attributes_for :diknas_converted_items, reject_if: :all_blank, allow_destroy: true

  def self.value_for(student, conversion) 
    d = DiknasConverted.find_by(student: student, academic_year_id: conversion.academic_year_id, academic_term_id: conversion.academic_term_id)
    d ? d.diknas_converted_items.where(diknas_conversion: conversion).take.try(:p_score) : "???"
  end
end
