if params[:barcode]
  json.extract! @product, :id, :code, :name, :barcode, :item_unit_id,:unit
else
  json.extract! @product, :id, :code, :name, :price, :min_stock, :max_stock, :stock_type, :item_unit_id, :item_category_id, :is_active, :barcode, :img_url, :created_at, :updated_at
end
