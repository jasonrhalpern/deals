class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :website
      t.references :category, index: true

      t.timestamps
    end
  end
end
