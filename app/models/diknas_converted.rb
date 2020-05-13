class DiknasConverted < ActiveRecord::Base
  belongs_to :student
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level

  has_many :diknas_converted_items, dependent: :destroy
  accepts_nested_attributes_for :diknas_converted_items, reject_if: :all_blank, allow_destroy: true

  def self.value_for(student, conversion) 
    d = DiknasConverted.find_by(student: student, academic_term_id: conversion.academic_term_id)
    d ? d.diknas_converted_items.where(diknas_conversion: conversion).take.try(:p_score) : "???"
  end

  def self.ipa_program?(student_id:, academic_year_id:)
    self.joins("left join diknas_converted_items on diknas_converted_items.diknas_converted_id = diknas_converteds.id")
        .joins("left join diknas_conversions on diknas_conversions.id = diknas_converted_items.diknas_conversion_id")
        .joins("left join diknas_courses on diknas_courses.id = diknas_conversions.diknas_course_id")
        .where(diknas_converteds: {student_id: student_id, academic_year_id: academic_year_id})
        .where('lower(diknas_courses.name) = ? or lower(diknas_courses.name) = ?',"fisika","biologi")
    .present?
  end

  def self.ips_program?(student_id:, academic_year_id:)
    !self.ipa_program?(student_id:student_id, academic_year_id:academic_year_id)
  end

  def self.program(student_id:, academic_year_id:, locale: 'id')
    self.ipa_program?(student_id:student_id, academic_year_id:academic_year_id) ?
      I18n.translate('student.tracks.NS', locale: locale) :
      I18n.translate('student.tracks.SS', locale: locale)
  end
end
