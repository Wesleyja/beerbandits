require 'byebug'
require 'json'
require 'open-uri'
urls = ["lat=-37.823767&lon=144.990841"]
urls.each_with_index do |latlong, index|
  url = "https://www.firstchoiceliquor.com.au/api/FindClosest/fc?#{latlong}"
  sleep(rand(15..20))
  file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:73.0) Gecko/20100101 Firefox/73.0").read
  data_hash = JSON.parse(file)
  data_hash.each do |store|
    if Store.find_by(latitude: store["latitude"].to_f).nil?
      Store.create(latitude: store["latitude"].to_f,longitude: store["longitude"].to_f, brand_id: Brand.find_by(name: "First Choice").id, name: "First Choice #{store["storeName"]}" )
      puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
    end
  end
end
