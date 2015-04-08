class Plan < ActiveRecord::Base

  validates :stripe_plan_id, :description, :trial_days, :interval, :active, presence: true
  validates :stripe_plan_id, uniqueness: true

end