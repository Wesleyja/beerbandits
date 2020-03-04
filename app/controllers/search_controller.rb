class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def preferences
  end

  def results
    # raise
    @stores = Store.all

    @markers = @stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        image_url: helpers.asset_url('logo.png')
      }
    end
  end
end
