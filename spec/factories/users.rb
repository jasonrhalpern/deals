FactoryGirl.define do
  factory :user do
    first_name 'Steve'
    last_name 'Jones'
    sequence(:email) { |n| "person#{n}@aol.com" }
    password 'abc123'
  end

  factory :admin, parent: :user do
    after(:create) do |user|
      user.user_roles << create(:admin_user_role)
    end
  end

  factory :user_with_business, parent: :user do
    transient do
      business_count 1
    end

    after(:create) do |user, evaluator|
      create_list(:business, evaluator.business_count, user: user)
    end
  end

  factory :user_with_favorites, parent: :user do
    transient do
      favorites_count 2
    end

    after(:create) do |user, evaluator|
      create_list(:favorite, evaluator.favorites_count, user: user)
    end
  end

end
