class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :stripe_cus_id
      t.string :stripe_sub_id
      t.datetime :active_until
      t.references :business, index: true

      t.timestamps
    end
  end
end
