class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :stripe_plan_id
      t.text :description
      t.integer :trial_days
      t.string :interval
      t.boolean :active

      t.timestamps
    end
  end
end
