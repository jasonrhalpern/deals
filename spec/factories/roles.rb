FactoryGirl.define do
  factory :role do
    name 'Admin'
  end

  factory :role_with_users, parent: :role do
    transient do
      users_count 2
    end

    after(:create) do |role, evaluator|
      create_list(:user_role, evaluator.users_count, role: role)
    end
  end
end