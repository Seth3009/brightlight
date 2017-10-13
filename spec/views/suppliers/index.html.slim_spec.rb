require 'rails_helper'

RSpec.describe "suppliers/index", type: :view do
  before(:each) do
    assign(:suppliers, [
      Supplier.create!(
        :company_name, => "Company Name,",
        :contact_name, => "Contact Name,",
        :address1, => "Address1,",
        :address2, => "Address2,",
        :city, => "City,",
        :province, => "Province,",
        :post_code, => "Post Code,",
        :country, => "Country,",
        :phone, => "Phone,",
        :mobile, => "Mobile,",
        :email, => "Email,",
        :website, => "Website,",
        :notes, => "Notes,",
        :logo, => "Logo,",
        :category, => "Category,",
        :status, => "Status,",
        :type, => "Type,",
        :group => "Group"
      ),
      Supplier.create!(
        :company_name, => "Company Name,",
        :contact_name, => "Contact Name,",
        :address1, => "Address1,",
        :address2, => "Address2,",
        :city, => "City,",
        :province, => "Province,",
        :post_code, => "Post Code,",
        :country, => "Country,",
        :phone, => "Phone,",
        :mobile, => "Mobile,",
        :email, => "Email,",
        :website, => "Website,",
        :notes, => "Notes,",
        :logo, => "Logo,",
        :category, => "Category,",
        :status, => "Status,",
        :type, => "Type,",
        :group => "Group"
      )
    ])
  end

  it "renders a list of suppliers" do
    render
    assert_select "tr>td", :text => "Company Name,".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Name,".to_s, :count => 2
    assert_select "tr>td", :text => "Address1,".to_s, :count => 2
    assert_select "tr>td", :text => "Address2,".to_s, :count => 2
    assert_select "tr>td", :text => "City,".to_s, :count => 2
    assert_select "tr>td", :text => "Province,".to_s, :count => 2
    assert_select "tr>td", :text => "Post Code,".to_s, :count => 2
    assert_select "tr>td", :text => "Country,".to_s, :count => 2
    assert_select "tr>td", :text => "Phone,".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile,".to_s, :count => 2
    assert_select "tr>td", :text => "Email,".to_s, :count => 2
    assert_select "tr>td", :text => "Website,".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Logo,".to_s, :count => 2
    assert_select "tr>td", :text => "Category,".to_s, :count => 2
    assert_select "tr>td", :text => "Status,".to_s, :count => 2
    assert_select "tr>td", :text => "Type,".to_s, :count => 2
    assert_select "tr>td", :text => "Group".to_s, :count => 2
  end
end
