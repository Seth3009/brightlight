namespace :data do
	desc "Import new products"
  task import_new_products: :environment do
    
    #import item unit ==========================================
    xl = Roo::Spreadsheet.open('lib/tasks/products.xlsx')
    sheet_unit = xl.sheet('unit')

    header = {abbreviation:'abbreviation',name:'name'}

    sheet_unit.each_with_index(header) do |row,i|
      next if i < 1
      @unit = ItemUnit.where(name:row[:name]).first
      if @unit.nil?
        item_unit = ItemUnit.new(
                    abbreviation:       row[:abbreviation],
                    name:       row[:name]                    
                  )
        item_unit.save
        puts "#{i}. #{item_unit.abbreviation} #{item_unit.name}"
      else        
        puts "#{i}. #{row[:name]} (Excel)"
      end
    end
    #==============================================================

    #import item category =========================================    
    sheet_category = xl.sheet('category')
    header = {code:'Code',name:'Name'}

    sheet_category.each_with_index(header) do |row,i|
      next if i < 1
      @category = ItemCategory.where(name:row[:name]).first
      if @category.nil?
        item_category = ItemCategory.new(
                    code:       row[:code],
                    name:       row[:name]                    
                  )
        item_category.save
        puts "#{i}. #{item_category.code} #{item_category.name}"
      else        
        puts "#{i}. #{row[:name]} (Excel)"
      end
    end
    #==============================================================

    #import products ==============================================    
    sheet_product = xl.sheet('product')
    header = {code:'code',name:'name', min_stock:'min_stock', stock_type:'stock_type',item_unit_id:'item_unit_id', item_category_id:'item_category_id',packs:'packs',packs_unit:'packs_unit'}

    sheet_product.each_with_index(header) do |row,i|
      next if i < 1
      @product = Product.where(name:row[:name]).first
      if @product.nil?
        @unit = ItemUnit.where(name:row[:item_unit_id]).first
        @category = ItemCategory.where(name:row[:item_category_id]).first
        product = Product.new(
                    code:       row[:code],
                    name:       row[:name],
                    min_stock:  row[:min_stock],
                    stock_type: row[:stock_type],
                    item_unit_id: @unit.id,
                    item_category_id: @category.id,
                    packs:      row[:packs],
                    packs_unit: row[:packs_unit]                    
                  )
        product.save
        puts "#{i}. #{product.code} #{product.name}"
        
      else        
        puts "#{i}. #{row[:name]} (Excel)"
      end
    end
    #====================================================================
  end
end
