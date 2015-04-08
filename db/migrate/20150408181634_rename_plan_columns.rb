class RenamePlanColumns < ActiveRecord::Migration
  def change
    rename_column :plans, :stripe_plan_id, :stripe_plan_token
  end
end
