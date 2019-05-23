class UpdateTeachersBooksToVersion11 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 11, revert_to_version: 10
  end
end
