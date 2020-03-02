class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.boolean :favorited
      t.jsonb :source_data

      t.timestamps
    end
  end
end
