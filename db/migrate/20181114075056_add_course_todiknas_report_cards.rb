class AddCourseTodiknasReportCards < ActiveRecord::Migration
  def change
    add_reference :diknas_report_cards, :course, foreign_key: true
    remove_column :diknas_report_cards, :course_belongs_to
  end
end
