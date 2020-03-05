class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def preferences
  end

  def results
    raise
    @stores = Store.all
    @markers = find_stores(@stores)
  end

  def favourites
  end

  private

  def find_stores(parameters)
    stores = parameters.near(params[:results][:location], 5)
    @markers = stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        image_url: helpers.asset_url('logo.png')
      }
    end
  end
end
