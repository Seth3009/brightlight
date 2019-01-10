class UpdateTeachersBooksToVersion10 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 10, revert_to_version: 9
  end
end
