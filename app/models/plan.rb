class Plan < ActiveRecord::Base

  validates :stripe_plan_id, :description, :trial_days, :interval, presence: true
  validates :stripe_plan_id, uniqueness: true
  validates :active, :inclusion => [true, false]

  scope :no_free_trial, -> { where(trial_days: 0) }
  scope :active, -> { where(active: true) }

end