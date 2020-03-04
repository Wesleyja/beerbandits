# PALE ALE BWS


require 'json'


file = File.read(Rails.root.join('lib', 'seeds', 'bws-pale-ale.json'))
data_hash = JSON.parse(file)
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
      else
        abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
      end
      Drink.create(
      name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
      category: "Pale Ale",
      volume: volume,
      abv: abv
      )
      # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
      # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
    end
  end

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

# LAGER BWS


file = File.read(Rails.root.join('lib', 'seeds', 'bws-lager.json'))
data_hash = JSON.parse(file)
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
      else
        abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
      end
      Drink.create(
      name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
      category: "Lager",
      volume: volume,
      abv: abv
      )
      # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
      # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
    end
  end

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

# IPA BWS


file = File.read(Rails.root.join('lib', 'seeds', 'bws-ipa.json'))
data_hash = JSON.parse(file)
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
      else
        abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
      end
      Drink.create(
      name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
      category: "IPA",
      volume: volume,
      abv: abv
      )
      # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
      # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
    end
  end

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


#CIDER BWS

file = File.read(Rails.root.join('lib', 'seeds', 'bws-cider.json'))
data_hash = JSON.parse(file)
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
      else
        abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
      end
      Drink.create(
      name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
      category: "Cider",
      volume: volume,
      abv: abv
      )
      # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
      # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
    end
  end

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
