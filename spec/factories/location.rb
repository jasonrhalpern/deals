FactoryGirl.define do
  factory :location do
    street "4 Maple Drive"
    city "Syosset"
    state "NY"
    zip_code "11732"
    phone_number "123-144-4234"
    latitude 1.5
    longitude 1.5
    business
  end
end