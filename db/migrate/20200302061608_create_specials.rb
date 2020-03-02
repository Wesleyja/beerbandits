class CreateSpecials < ActiveRecord::Migration[5.2]
  def change
    create_table :specials do |t|
      t.references :store, foreign_key: true
      t.string :payment_token

      t.timestamps
    end
  end
end
