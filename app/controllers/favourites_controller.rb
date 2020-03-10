class FavouritesController < ApplicationController

  def index
    @searches = Search.where(user: current_user)
  end
end
