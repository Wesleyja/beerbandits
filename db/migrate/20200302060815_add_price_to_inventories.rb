class AddPriceToInventories < ActiveRecord::Migration[5.2]
  def change
    add_monetize :inventories, :price, currency: { present: false }
  end
end
