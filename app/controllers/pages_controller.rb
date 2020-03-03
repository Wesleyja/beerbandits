class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def about
  end

  def preferences
  end

  def results
    @stores = Store.geocoded

    @markers = @stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end
end
