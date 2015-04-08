FactoryGirl.define do
  factory :plan do
    stripe_plan_id 'gold'
    description 'this is the gold plan'
    trial_days 30
    interval 'month'
    active true
  end

end