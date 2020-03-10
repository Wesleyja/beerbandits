require 'json'
require 'csv'
## ---------------------- BWS -----------------------
file_paleale = File.read(Rails.root.join('lib', 'seeds', 'bws-pale-ale.json'))
file_lager = File.read(Rails.root.join('lib', 'seeds', 'bws-lager.json'))
file_ipa = File.read(Rails.root.join('lib', 'seeds', 'bws-ipa.json'))
file_cider = File.read(Rails.root.join('lib', 'seeds', 'bws-cider.json'))
bws_jsons = [file_lager, file_ipa, file_paleale, file_cider]
categories = ["Lager", "IPA", "Pale Ale", "Cider"]
bws_jsons.each_with_index do |url, index|
  data_hash = JSON.parse(url)
  data_hash["Bundles"].each do |beer|
    beer["Products"].each do |x|
    # if the value is true, then its the hash with the single unit bottle, which has the % and Brand and Volume
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"] == "1"
        if x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorsize" }.nil?
          volume = x["PackageSize"].gsub(/\D/, "").to_i || 0
        else
          volume = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorsize" }]["Value"].gsub(/\D/, "").to_i
        end
        if x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }.nil?
          abv = 0
        elsif x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f > 12.0
          x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "standarddrinks%" }]["Value"].gsub(/\D$/, "").to_f
        else
          abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
        end
        Drink.create(
        name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
        category: "#{categories[index]}",
        volume: volume,
        abv: abv,
        Brand: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
        )
        puts "Drink = #{Drink.last.name}"
        # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
        # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
      end
    end

    puts "Making Products"

    beer["Products"].each do |x|
      # if Drink.find_by(product_number: #value ).nil? -> then add new product / otherwise update
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"].empty?
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "displayunitquantity" }]["Value"].to_i
      else
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"].to_i
      end
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "webpacktype" }]["Value"] == "Case" && x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"] == "1"
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "displayunitquantity" }]["Value"].to_i
      end
      Product.create(drink_id: Drink.last.id, size: size)
      stores = Store.where(brand_id: Brand.find_by(name: 'BWS')).ids
      stores.each do |id|
        Inventory.create(price: x["Price"], store_id: id)
        InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
        puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
      end
    end
  end
end
# -----------------------------------------------------------------------
# -------------------------- Dan Murphy's --------------------------------
file_paleale = File.read(Rails.root.join('lib', 'seeds', 'dan-paleale.json'))
file_lager = File.read(Rails.root.join('lib', 'seeds', 'dan-lager.json'))
file_ipa = File.read(Rails.root.join('lib', 'seeds', 'dan-ipa.json'))
file_cider = File.read(Rails.root.join('lib', 'seeds', 'dan-cider.json'))
dan_jsons = [file_lager, file_ipa, file_paleale, file_cider]
categories = ["Lager", "IPA", "Pale Ale", "Cider"]
dan_jsons.each_with_index do |url, index|
  data_hash = JSON.parse(url)
  data_hash["Bundles"].each do |beer|
    beer["Products"].each do |x|
    # if the value is true, then its the hash with the single unit bottle, which has the % and Brand and Volume
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"] == "1"
        if x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorsize" }.nil?
          volume = x["PackageSize"].gsub(/\D/, "").to_i || 0
        else
          volume = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorsize" }]["Value"].gsub(/\D/, "").to_i
        end
        if x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }.nil?
          abv = 0
        elsif x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f > 12.0
          x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "standarddrinks%" }]["Value"].gsub(/\D$/, "").to_f
        else
          abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
        end
        Drink.create(
        name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
        category: "#{categories[index]}",
        volume: volume,
        abv: abv,
        Brand: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
        )
        puts "Drink = #{Drink.last.name}"
        # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
        # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
      end
    end

    puts "Making Products"

    beer["Products"].each do |x|
      # if Drink.find_by(product_number: #value ).nil? -> then add new product / otherwise update
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"].empty?
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "displayunitquantity" }]["Value"].to_i
      else
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"].to_i
      end
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "webpacktype" }]["Value"] == "Case" && x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"] == "1"
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "displayunitquantity" }]["Value"].to_i
      end
      Product.create(drink_id: Drink.last.id, size: size)
      stores = Store.where(brand_id: Brand.find_by(name: "Dan Murphy's")).ids
      stores.each do |id|
        Inventory.create(price: x["Price"], store_id: id)
        InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
        puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
      end
    end
  end
end
# -----------------------------------------------------------------------
# -------------------------- LiqourLand --------------------------------
csv_options = { col_sep: ',', headers: :first_row }
csv_ll = File.read(Rails.root.join('lib', 'seeds', 'll-drinks.csv'))
csv = CSV.parse(csv_text, csv_options)
csv.each do |row|
  Drink.create(
    name: row['Name'],
    category: row['Category'],
    volume: row['volume'],
    abv: row['abv'],
    brand: row['brand']
    )
  Product.create(drink_id: Drink.last.id, size: row['size'])
  stores = Store.where(brand_id: Brand.find_by(name: "Liqourland")).ids
  stores.each do |id|
    Inventory.create(price: row['price'], store_id: id)
    InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
    puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
  end
end
# -----------------------------------------------------------------------
# -------------------------- First Choice --------------------------------
csv_options = { col_sep: ',', headers: :first_row }
csv_ll = File.read(Rails.root.join('lib', 'seeds', 'fc-drinks.csv'))
csv = CSV.parse(csv_text, csv_options)
csv.each do |row|
  Drink.create(
    name: row['Name'],
    category: row['Category'],
    volume: row['volume'],
    abv: row['abv'],
    brand: row['brand']
    )
  Product.create(drink_id: Drink.last.id, size: row['size'])
  stores = Store.where(brand_id: Brand.find_by(name: "First Choice")).ids
  stores.each do |id|
    Inventory.create(price: row['price'], store_id: id)
    InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
    puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
  end
end
# -----------------------------------------------------------------------


































