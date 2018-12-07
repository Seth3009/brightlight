class ChangeColumnNameInDiknasConvertedItems < ActiveRecord::Migration
  def change
    rename_column :diknas_converted_items, :P_score, :p_score
    rename_column :diknas_converted_items, :T_score, :t_score
  end
end
