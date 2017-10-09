class UpdateTeachersBooksToVersion7 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 7, revert_to_version: 6
  end
end
