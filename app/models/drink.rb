class Drink < ApplicationRecord
  has_many :products

  def standard_drink
    abv * volume / 1000 * 0.789
  end
end
