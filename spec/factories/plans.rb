FactoryGirl.define do
  factory :plan do
    sequence(:stripe_plan_id) { |n| "Plan-#{n}" }
    description 'this is the gold plan'
    trial_days 30
    interval 'month'
    active true
  end

end