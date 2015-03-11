FactoryGirl.define do

  factory :business do
    sequence(:name) { |n| "A Pizza Joint#{n}" }
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

  factory :business_with_favorites, parent: :business do
    transient do
      favorites_count 3
    end

    after(:create) do |business, evaluator|
      create_list(:favorite, evaluator.favorites_count, business: business)
    end
  end

end