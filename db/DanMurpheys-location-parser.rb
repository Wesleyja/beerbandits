require 'byebug'
require 'json'
require 'open-uri'

url = "https://api.danmurphys.com.au/apis/ui/StoreLocator/Stores/danmurphys"
file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:73.0) Gecko/20100101 Firefox/73.0").read
data_hash = JSON.parse(file)
data_hash["Stores"].each do |store|
  if store["State"] == "VIC"
    Store.create(latitude: store["Latitude"].to_f,longitude: store["Longitude"].to_f, brand_id: Brand.find_by(name: "Dan Murphy's").id, name: "Dan Murphy's #{store["Name"]}" )
    puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
  end
end
