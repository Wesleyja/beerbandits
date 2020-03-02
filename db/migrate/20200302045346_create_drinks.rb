class CreateDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :drinks do |t|
      t.string :strength
      t.string :name
      t.string :category
      t.integer :volume
      t.float :abv

      t.timestamps
    end
  end
end
