def filter_size_category(item, params)
  if params[:results]["size"] == "6"
    size = [4, 6]
  elsif params[:results]["size"] == "Case"
    size = [24, 30]
  elsif params[:results]["size"] == "1"
    size = [1]
  else
    size = [0]
  end

  params[:results]["category"].include?(item.product.drink.category)  \
    && size.include?(item.product.size)
end

#filtering for category and size

results = []
InventoryProduct.all.each do |item|
  if filter_size_category(item, params)
    results << item
  end
end

#calculations for price and location
final_results = {}
results.each do |result|

=begin



=end






Store.find(result.inventory.store_id).longitude
Store.find(result.inventory.store_id).latitude

Store.find(result.inventory.store_id).distance_to(Geocoder.search("Richmond, Victoria, Australia").first.coordinates)


Geocoder.search("Richmond, Victoria, Australia").first.coordinates

# 590.4761905 m per $5
# (590.4761905/5) m per $1
=begin

Lowest is best =
((590.4761905/5)*price)/distance in metres


=end
#category
item.product.drink.category
#size
item.product.size
#Price
item.inventory.price_cents
#location
item.inventory.store.latitude
item.inventory.store.longitude



InventoryProduct.product.drink.category == "Cider"


params[:results]
<ActionController::Parameters {"categoty"=>["IPA", "Lager"], "size"=>"6", "location"=>"Richmond, Victoria, Australia"} permitted: false>
