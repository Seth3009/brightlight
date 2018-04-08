json.extract! @product, :id, :code, :name, :price, :min_stock, :max_stock, :stock_type, :is_active, :barcode, :img_url, :created_at, :updated_at
json.unit_name @product.item_unit.try(:name)
json.unit @product.item_unit.try(:abbreviation)
json.category @product.item_category.try(:name)
