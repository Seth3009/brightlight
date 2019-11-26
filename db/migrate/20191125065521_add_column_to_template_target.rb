class AddColumnToTemplateTarget < ActiveRecord::Migration
  def change
    add_column :template_targets, :placeholders, :string
  end
end
