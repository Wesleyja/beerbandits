class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :location
      t.references :user, foreign_key: true
      t.float :longitude
      t.float :latitude
      t.string :name
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
