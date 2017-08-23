class UpdateTeachersBooksToVersion5 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 5, revert_to_version: 4
  end
end
