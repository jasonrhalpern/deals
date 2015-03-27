class AddIndexToFavorites < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :location_id]
  end
end
