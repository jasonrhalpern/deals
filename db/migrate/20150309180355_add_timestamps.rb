class AddTimestamps < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.timestamps
    end

    change_table :roles do |t|
      t.timestamps
    end

    change_table :user_roles do |t|
      t.timestamps
    end
  end
end
