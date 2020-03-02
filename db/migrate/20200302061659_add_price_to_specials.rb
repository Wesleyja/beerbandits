class AddPriceToSpecials < ActiveRecord::Migration[5.2]
  def change
    add_monetize :specials, :price, currency: { present: false }
  end
end
