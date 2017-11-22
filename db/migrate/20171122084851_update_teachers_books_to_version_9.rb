class UpdateTeachersBooksToVersion9 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 9, revert_to_version: 8
  end
end
