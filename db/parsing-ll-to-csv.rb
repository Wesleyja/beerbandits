require 'json'
require 'open-uri'
require 'csv'
beer_url = "https://www.liquorland.com.au/api/products/ll/vic/beer/#{beer_reference_id}"
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }

jsons = []
ll_urls.each_with_index do |url, index|
  file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:73.0) Gecko/20100101 Firefox/73.0").read
  data_hash = JSON.parse(file)
  data_hash["products"].each do |beer|
    beer_reference_id = beer["id"]
    beer_url = "https://www.liquorland.com.au/api/products/ll/vic/beer/#{beer_reference_id}"
    # drastically increase this sleep value cause fuck Liqourland API
    sleep(rand(20..30))
    result = URI.open(beer_url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:73.0) Gecko/20100101 Firefox/73.0").read
    beer_hash = JSON.parse(result)
    Drink.create(name: beer_hash["product"]["name"], category: "#{categories[index]}", volume: beer_hash["product"]["volumeMl"], brand: beer_hash["product"]["brand"])
    puts "#{Drink.last.name}"
    size_label = beer_hash["product"]["unitOfMeasure"]
    if size_label == "CTN24"
      size = 24
    elsif size_label == "PACK4"
      size = 4
    elsif size_label == "PACK6"
      size = 6
    elsif size_label == "CTN12"
      size = 12
    elsif size_label == "PACK30"
      size = 30
    elsif size_label == "PACK10"
      size = 10
    else
      size = 1
    end
    Product.create(drink_id: Drink.last.id, size: size)
    stores = Store.where(brand_id: Brand.find_by(name: 'Liqourland')).ids
    stores.each do |id|
        Inventory.create(price: beer_hash["product"]["price"]["current"], store_id: id)
        InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
        puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
      end
  end
end



csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
filepath    = 'beers.csv'

CSV.open(filepath, 'wb', csv_options) do |csv|
  csv << ['Name', 'Appearance', 'Origin']
  csv << ['Asahi', 'Pale Lager', 'Japan']
  csv << ['Guinness', 'Stout', 'Ireland']
  # ...
end


