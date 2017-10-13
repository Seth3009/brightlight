class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :company_name,
      t.string :contact_name,
      t.string :address1,
      t.string :address2,
      t.string :city,
      t.string :province,
      t.string :post_code,
      t.string :country,
      t.string :phone,
      t.string :mobile,
      t.string :email,
      t.string :website,
      t.string :notes,
      t.string :logo,
      t.string :category,
      t.string :status,
      t.string :type,
      t.string :group

      t.timestamps null: false
    end
  end
end
