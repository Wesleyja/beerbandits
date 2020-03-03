class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def about
  end

  def preferences
  end

  def results
    @drinks = Drink.all
    @stores = Store.all
    @products = Product.all
  end
end
