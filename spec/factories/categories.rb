FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Restaurants #{n}" }
  end

  factory :category_with_businesses, parent: :category do
    transient do
      businesses_count 2
    end

    after(:create) do |category, evaluator|
      create_list(:business, evaluator.businesses_count, category: category)
    end
  end

end