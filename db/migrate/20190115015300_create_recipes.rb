class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.references :food, index: true, foreign_key: true
      t.references :raw_food, index: true, foreign_key: true
      t.integer :recipe_portion, default:710
      t.float :qty, default:0.0
      t.float :custom_size, default:0.0
      t.float :size_divider, default:0.0
      t.float :portion_size, default:0.0
      t.float :gr1_portion, default:0.0
      t.float :gr2_portion, default:0.0
      t.float :sol_portion, default:0.0
      t.float :sor_portion, default:0.0
      t.float :adult_portion, default:0.0

      t.timestamps null: false
    end
  end
end
