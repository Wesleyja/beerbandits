class AddBrandToDrink < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :brand, :string
  end
end
