class RenameFavoriteToFavourite < ActiveRecord::Migration[5.2]
  def change
    rename_column :searches, :favorited, :favourited
  end
end
