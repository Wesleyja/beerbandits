class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def preferences
  end

  def results
    @stores = Store.all

    @markers = @stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end
end
