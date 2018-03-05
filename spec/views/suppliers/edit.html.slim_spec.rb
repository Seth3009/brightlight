require 'rails_helper'

RSpec.describe "suppliers/edit", type: :view do
  before(:each) do
    @supplier = assign(:supplier, Supplier.create!(
      :company_name, => "MyString",
      :contact_name, => "MyString",
      :address1, => "MyString",
      :address2, => "MyString",
      :city, => "MyString",
      :province, => "MyString",
      :post_code, => "MyString",
      :country, => "MyString",
      :phone, => "MyString",
      :mobile, => "MyString",
      :email, => "MyString",
      :website, => "MyString",
      :notes, => "MyString",
      :logo, => "MyString",
      :category, => "MyString",
      :status, => "MyString",
      :type, => "MyString",
      :group => "MyString"
    ))
  end

  it "renders the edit supplier form" do
    render

    assert_select "form[action=?][method=?]", supplier_path(@supplier), "post" do

      assert_select "input#supplier_company_name,[name=?]", "supplier[company_name,]"

      assert_select "input#supplier_contact_name,[name=?]", "supplier[contact_name,]"

      assert_select "input#supplier_address1,[name=?]", "supplier[address1,]"

      assert_select "input#supplier_address2,[name=?]", "supplier[address2,]"

      assert_select "input#supplier_city,[name=?]", "supplier[city,]"

      assert_select "input#supplier_province,[name=?]", "supplier[province,]"

      assert_select "input#supplier_post_code,[name=?]", "supplier[post_code,]"

      assert_select "input#supplier_country,[name=?]", "supplier[country,]"

      assert_select "input#supplier_phone,[name=?]", "supplier[phone,]"

      assert_select "input#supplier_mobile,[name=?]", "supplier[mobile,]"

      assert_select "input#supplier_email,[name=?]", "supplier[email,]"

      assert_select "input#supplier_website,[name=?]", "supplier[website,]"

      assert_select "input#supplier_notes,[name=?]", "supplier[notes,]"

      assert_select "input#supplier_logo,[name=?]", "supplier[logo,]"

      assert_select "input#supplier_category,[name=?]", "supplier[category,]"

      assert_select "input#supplier_status,[name=?]", "supplier[status,]"

      assert_select "input#supplier_type,[name=?]", "supplier[type,]"

      assert_select "input#supplier_group[name=?]", "supplier[group]"
    end
  end
end
