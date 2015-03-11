class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :status
      t.text :description
      t.date :start_date
      t.date :end_date
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.references :business, index: true

      t.timestamps
    end
  end
end
