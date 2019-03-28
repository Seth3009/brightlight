class CreateLunchMenus < ActiveRecord::Migration
  def change
    create_table :lunch_menus do |t|
      t.date :lunch_date
      t.references :food, index: true, foreign_key: true
      t.integer :adj_g1, default:0
      t.integer :adj_g4, default:0
      t.integer :adj_sol, default:0
      t.integer :adj_sor, default:0
      t.integer :adj_adult, default:0
      t.integer :total_adj, default:0
      t.references :academic_year, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
