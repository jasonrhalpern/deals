class ChangeFavoritesColumnName < ActiveRecord::Migration
  def change
    rename_column :favorites, :business_id, :location_id
  end
end
