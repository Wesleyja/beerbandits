class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @searches = Search.where(user: current_user)
  end

  def favourite
    @search = Search.find(params[:id])
    if @search.favourited
      @search.update(favourited: false)
    else
      @search.update(favourited: true)
    end
    @search.update(favourited: true, name: params[:search][:name]) if params[:search][:name]
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy
  end
end
