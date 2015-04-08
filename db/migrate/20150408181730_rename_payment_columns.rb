class RenamePaymentColumns < ActiveRecord::Migration
  def change
    rename_column :payments, :stripe_cus_id, :stripe_cus_token
    rename_column :payments, :stripe_sub_id, :stripe_sub_token
  end
end
