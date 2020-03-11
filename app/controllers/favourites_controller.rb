class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @searches = Search.where(user: current_user)
  end

  def toggle_favourite
    @search = Search.find(params[:id])
    if @search.favourited
      @search.update(favourited: false)
    else
      @search.update(favourited: true)
    end
    @searches = Search.where(user: current_user)
  end

  def update
    @search = Search.find(params[:id])
    @search.update(favourited: true, name: params[:search][:name]) if params[:search][:name]
    @searches = Search.where(user: current_user)
    respond_to do |format|
      format.js { render 'favourites/toggle_favourite' }
    end
  end

  def destroy
    @search = Search.find(params[:id])
    if @search.destroy
      respond_to do |format|
        format.js
      end
    end
  end
end
