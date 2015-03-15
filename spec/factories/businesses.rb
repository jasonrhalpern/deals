FactoryGirl.define do

  factory :business do
    sequence(:name) { |n| "A Pizza Joint#{n}" }
    sequence(:website) { |n| "http://www.apizzajoint#{n}.com" }
    avatar { fixture_file_upload(Rails.root.join('spec/uploads/test_avatar.png'), 'image/png') }
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

  factory :business_with_deals, parent: :business do
    transient do
      deals_count 2
    end

    after(:create) do |business, evaluator|
      create_list(:deal, evaluator.deals_count, business: business)
    end
  end

end