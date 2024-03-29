FactoryGirl.define do
  factory :location do
    street "8 Pond Drive"
    city "Syosset"
    state "NY"
    zip_code "11791"
    phone_number "123-144-4234"
    business
  end

  factory :location_with_deals, parent: :location do
    transient do
      deals_count 3
    end

    after(:create) do |location, evaluator|
      create_list(:location_deal, evaluator.deals_count, location: location)
    end
  end

  factory :location_with_favorites, parent: :location do
    transient do
      favorites_count 3
    end

    after(:create) do |location, evaluator|
      create_list(:favorite, evaluator.favorites_count, location: location)
    end
  end
end