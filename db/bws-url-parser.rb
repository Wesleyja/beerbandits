require 'open-uri'
require 'json'

bws_cider_url = "https://api.bws.com.au/apis/ui/Browse?Location=%2Fbeer%2Fcider&banner=true&bannerSlotIds=Category_Desktop&department=beer&isRequestAds=false&maxNumberOfAds=4&pageNumber=1&pageSize=999&pageType=Category&sortType=Browse_Relevance_LocalSales&subDepartment=cider"
bws_paleale_url = "https://api.bws.com.au/apis/ui/Browse?Location=%2Fbeer%2Fbeer-style%2Fpale-ale&banner=true&bannerSlotIds=Category_Desktop&category=pale+ale&department=beer&isRequestAds=false&maxNumberOfAds=4&pageNumber=1&pageSize=200&pageType=Category&sortType=Browse_Relevance_LocalSales&subDepartment=beer+style"
bws_ipa_url = "https://api.bws.com.au/apis/ui/Browse?Location=%2Fbeer%2Fbeer-style%2Findian-pale-ale&banner=true&bannerSlotIds=Category_Desktop&category=indian+pale+ale&department=beer&isRequestAds=false&maxNumberOfAds=4&pageNumber=1&pageSize=100&pageType=Category&sortType=Browse_Relevance_LocalSales&subDepartment=beer+style"
bws_lager_url = "https://api.bws.com.au/apis/ui/Browse?Location=%2Fbeer%2Fbeer-style%2Flager&banner=true&bannerSlotIds=Category_Desktop&category=lager&department=beer&isRequestAds=false&maxNumberOfAds=4&pageNumber=1&pageSize=999&pageType=Category&sortType=Browse_Relevance_LocalSales&subDepartment=beer+style"
bws_url = [bws_lager_url, bws_ipa_url, bws_paleale_url, bws_cider_url]
categories = ["Lager", "IPA", "Pale Ale", "Cider"]
bws_url.each_with_index do |url, index|
  bws_open = URI.open(url).read
  data_hash = JSON.parse(bws_open)
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
          x["AdditionalDetails"].find_index { |i| i["Name"] == "standarddrinks" }
        else
          abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
        end
        Drink.create(
        name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
        category: "#{categories[index]}",
        volume: volume,
        abv: abv
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

