class StudentActivityController < ApplicationController
  def insert_multiple_member
    #StudentBook.update(params[:student_books].keys, params[:student_books].values)
    StudentActivity.create(params[:student_activities].keys,params[:student_activities].values)
  end
end
