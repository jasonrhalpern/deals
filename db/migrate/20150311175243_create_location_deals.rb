class CreateLocationDeals < ActiveRecord::Migration
  def change
    create_table :location_deals do |t|
      t.references :deal, index: true
      t.references :location, index: true
    end
  end
end
