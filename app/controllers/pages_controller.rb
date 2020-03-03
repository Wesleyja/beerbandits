class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def about
  end

  def preferences
    @drinks = Drink.all
    @stores = Store.all
    @products = Product.all
  end

  def results
  end


  private


end
