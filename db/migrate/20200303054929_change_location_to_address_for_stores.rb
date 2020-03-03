class ChangeLocationToAddressForStores < ActiveRecord::Migration[5.2]
  def change
    rename_column :stores, :location, :address
  end
end
