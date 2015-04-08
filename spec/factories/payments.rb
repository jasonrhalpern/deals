FactoryGirl.define do
  factory :payment do
    stripe_cus_token 'cus_1'
    stripe_sub_token 'sub_1'
    active_until 1.day.from_now
    business
  end

  factory :inactive_payment, parent: :payment do
    active_until 1.day.ago
  end

end