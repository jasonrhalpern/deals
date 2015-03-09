class RenameMerchantsToBusinesses < ActiveRecord::Migration
  def change
    rename_table :merchants, :businesses

  end
end
