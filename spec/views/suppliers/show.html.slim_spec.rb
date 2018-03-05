require 'rails_helper'

RSpec.describe "suppliers/show", type: :view do
  before(:each) do
    @supplier = assign(:supplier, Supplier.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Company Name,/)
    expect(rendered).to match(/Contact Name,/)
    expect(rendered).to match(/Address1,/)
    expect(rendered).to match(/Address2,/)
    expect(rendered).to match(/City,/)
    expect(rendered).to match(/Province,/)
    expect(rendered).to match(/Post Code,/)
    expect(rendered).to match(/Country,/)
    expect(rendered).to match(/Phone,/)
    expect(rendered).to match(/Mobile,/)
    expect(rendered).to match(/Email,/)
    expect(rendered).to match(/Website,/)
    expect(rendered).to match(/Notes,/)
    expect(rendered).to match(/Logo,/)
    expect(rendered).to match(/Category,/)
    expect(rendered).to match(/Status,/)
    expect(rendered).to match(/Type,/)
    expect(rendered).to match(/Group/)
  end
end
