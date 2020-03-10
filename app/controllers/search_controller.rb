class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def preferences
  end

  def results
    the_params = params[:filters] || params[:results]
    the_params[:category] = the_params[:category].split(' ') if params[:filters]
    if the_params[:size] == "pack"
      size = [4, 6]
    elsif the_params[:size] == "case"
      size = [24, 30]
    else
      size = [0]
    end
    stores = Store.all.near(the_params[:location], 2)
    store_ids = stores.collect(&:id)
    results = InventoryProduct.joins(:product)
                              .joins(product: :drink)
                              .joins(inventory: :store)
                              .where(products: { size: size })
                              .where(drinks: { category: the_params[:category] })
                              .where(stores: { id: store_ids })

    # results = InventoryProduct.all.select do  |inventory_product|
    #   the_params[:size].include?(inventory_product.product.size.to_s) \
    #   &&  the_params[:category].include?(inventory_product.product.drink.category)
    # end
    final_results = {}
    @current_location = Geocoder.search(the_params[:location]).first.coordinates
    results.each do |result|
      if stores.collect { |x| x.id }.include?(result.inventory.store_id)
        price = (result.inventory.price_cents.to_f / 100)
        distance = Store.find(result.inventory.store_id).distance_to(@current_location) * 1000
        ranked_value = (distance / 118) + (price)
        final_results[result] = ranked_value
      end
    end

    @final_results = final_results.sort {|a,b| a[1]<=>b[1]}
    if the_params[:options].class == String
      @final_results = new_distance_param(the_params[:options], the_params[:amount].to_i)
    end

    @markers = find_stores(stores)
  end

  def favourites
  end

  private

  def new_distance_param(type, value)
    raise
    @new_value = value
    @new_value = (500 / 6) * value if type == "min"
    new_results_hash = {}
    new_results = @final_results.collect { |k, _v| k }
    new_results.each do |result|
      distance = result.inventory.store.distance_to(@current_location) * 1000
      new_ranking = (@new_value * (result.inventory.price_cents.to_f / 100)) / distance
      new_results_hash[result] = new_ranking
    end
    @final_results = new_results_hash.sort_by { |_k, v| v }
  end

  def standard_drinks_price
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


