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

end