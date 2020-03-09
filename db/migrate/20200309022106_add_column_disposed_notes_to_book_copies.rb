class AddColumnDisposedNotesToBookCopies < ActiveRecord::Migration
  def change
    add_column :book_copies, :disposed_notes, :string
  end
end
