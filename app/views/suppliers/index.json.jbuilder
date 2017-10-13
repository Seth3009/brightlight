json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :company_name,, :contact_name,, :address1,, :address2,, :city,, :province,, :post_code,, :country,, :phone,, :mobile,, :email,, :website,, :notes,, :logo,, :category,, :status,, :type,, :group
  json.url supplier_url(supplier, format: :json)
end
