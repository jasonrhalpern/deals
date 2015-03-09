FactoryGirl.define do

  factory :business do
    name 'A Pizza Joint'
    sequence(:website) { |n| "http://www.apizzajoint#{n}.com" }
    category
    user
  end

  factory :business_with_locations, parent: :business do
    transient do
      locations_count 3
    end

    after(:create) do |business, evaluator|
      create_list(:location, evaluator.locations_count, business: business)
    end
  end

end