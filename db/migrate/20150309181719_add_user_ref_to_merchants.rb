class AddUserRefToMerchants < ActiveRecord::Migration
  def change
    add_reference :merchants, :user, index: true
  end
end
