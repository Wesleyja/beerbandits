class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def preferences
  end

  def results
    if params[:results][:size] == "pack"
      size = [4, 6]
    elsif params[:results][:size] == "case"
      size = [24, 30]
    elsif params[:results][:size] == "single"
      size = [1]
    else
      size = [0]
    end
    stores = Store.all.near(params[:results][:location], 2)
    store_ids = stores.collect { |x| x.id }
    results = InventoryProduct.joins(:product)
      .joins(product: :drink)
      .joins(inventory: :store)
      .where(products: { size: size })
      .where(drinks: { category: params[:results][:category] })
      .where(stores: { id: store_ids })

    # results = InventoryProduct.all.select do  |inventory_product|
    #   params[:results][:size].include?(inventory_product.product.size.to_s) \
    #   &&  params[:results][:category].include?(inventory_product.product.drink.category)
    # end
    final_results = {}
    @current_location = Geocoder.search(params[:results][:location]).first.coordinates
    results.each do |result|
      if stores.include?(result.inventory.store)
        price = result.inventory.price_cents.to_f/100
        distance = Store.find(result.inventory.store_id).distance_to(@current_location) * 1000
        ranked_value = ((590.4761905/5)*price)/distance
        final_results[result] = ranked_value
      end
    end
    @final_results = final_results.sort_by {|k, v| [v, k]}
    @markers = find_stores(stores)
  end

  def favourites
  end

  private

  def new_distance_param(value)
    if
      # new value params has minutes
      new_value = (500/6)*value
    end
    byebug
    new_value = value
    current_location = Geocoder.search(params[:results][:location]).first.coordinates
    new_results_hash = {}
    new_results = @final_results.collect { |x| x.first }
    new_results.each do |result|
      distance = result.inventory.store.distance_to(@current_location) * 1000
      new_ranking = (new_value * (result.inventory.price_cents.to_f/100))/distance
      new_results_hash[result] = new_ranking
    end
    @final_results = new_results
  end

  def standard_drinks_price
    byebug
    @final_results.each do |result|
      result[1] = result[1] / (result[0].product.drink.standard_drink)
    end
  end


  def find_stores(stores)
    @markers = stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        image_url: helpers.asset_url('logo.png')
      }
    end
  end
end


