class UpdateTeachersBooksToVersion6 < ActiveRecord::Migration
  def change
    update_view :teachers_books, version: 6, revert_to_version: 5
  end
end
