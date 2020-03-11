class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @searches = Search.where(user: current_user)
  end

  def update
    search = Search.find(params[:search_id])
    search.update(name: params[:name])
  end

  def destroy
  end

  def favourite
  end
end
