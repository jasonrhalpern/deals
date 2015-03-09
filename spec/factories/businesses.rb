FactoryGirl.define do

  factory :business do
    name 'A Pizza Joint'
    sequence(:website) { |n| "http://www.apizzajoint#{n}.com" }
    category
    user
  end

end