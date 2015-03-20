FactoryGirl.define do
  factory :deal do
    status :active
    description "Best deal ever"
    start_date Date.today
    end_date Date.tomorrow
    monday false
    tuesday false
    wednesday false
    thursday false
    friday true
    saturday true
    sunday false
    business
  end

  factory :deal_with_locations, parent: :deal do
    transient do
      locations_count 2
    end

    after(:create) do |deal, evaluator|
      create_list(:location_deal, evaluator.locations_count, deal: deal)
    end
  end

  factory :disabled_deal,  parent: :deal do
    status :disabled
  end

end