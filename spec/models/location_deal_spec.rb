require 'rails_helper'

describe LocationDeal do

  it 'has a valid factory' do
    expect(build_stubbed(:location_deal)).to be_valid
  end

  it 'is invalid without a location' do
    expect(build_stubbed(:location_deal, location: nil)).to have(1).errors_on(:location)
  end

  it 'is invalid without a deal' do
    expect(build_stubbed(:location_deal, deal: nil)).to have(1).errors_on(:deal)
  end

  it 'is invalid if the deal is already associated with this location' do
    location_deal1 = create(:location_deal)
    expect(build_stubbed(:location_deal, location_id: location_deal1.location_id, deal_id: location_deal1.deal_id)).to have(1).errors_on(:location_id)
  end

  it 'returns an array of location deals associated with active deals' do
    deal1 = build(:deal)
    deal2 = build(:disabled_deal)
    location_deal1 = create(:location_deal, :deal => deal1)
    location_deal2 = create(:location_deal, :deal => deal2)

    expect(LocationDeal.active).to eq([location_deal1])
  end

  it 'returns an array of location deals associated with current deals' do
    deal1 = build(:deal, :start_date => Date.today, :end_date => Date.tomorrow)
    deal2 = build(:deal, :start_date => Date.today - 3.days, :end_date => Date.today - 1.day)
    deal3 = build(:deal, :start_date => Date.today - 1.week, :end_date => Date.today + 1.month)
    deal4 = build(:deal, :start_date => Date.today + 3.weeks, :end_date => Date.today + 4.weeks)
    deal5 = build(:deal, :start_date => Date.today + 1.week, :end_date => Date.today + 2.weeks)
    location_deal1 = create(:location_deal, :deal => deal1)
    location_deal2 = create(:location_deal, :deal => deal2)
    location_deal3 = create(:location_deal, :deal => deal3)
    location_deal4 = create(:location_deal, :deal => deal4)
    location_deal5 = create(:location_deal, :deal => deal5)

    expect(LocationDeal.current(Date.today)).to eq([location_deal1, location_deal3, location_deal5])
  end

  it 'returns an array of location deals associated with ongoing deals' do
    deal1 = build(:deal, :end_date => Date.yesterday)
    deal2 = build(:deal, :end_date => Date.tomorrow)
    deal3 = build(:deal, :end_date => Date.today + 1.month)
    location_deal1 = create(:location_deal, :deal => deal1)
    location_deal2 = create(:location_deal, :deal => deal2)
    location_deal3 = create(:location_deal, :deal => deal3)

    expect(LocationDeal.upcoming).to eq([location_deal2, location_deal3])
  end

  it 'can get the date from a day of the week' do
    tomorrow = Date::DAYNAMES[Date.tomorrow.wday]
    expect(LocationDeal.get_date_from_day(tomorrow)).to eq(Date.tomorrow)
  end


end