class UpdateTeachersBooksToVersion8 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 8, revert_to_version: 7
  end
end
