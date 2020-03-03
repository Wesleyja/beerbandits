class RemoveStrengthFromDrink < ActiveRecord::Migration[5.2]
  def change
    remove_column :drinks, :strength, :string
  end
end
