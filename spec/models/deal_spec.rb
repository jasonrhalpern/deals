require 'rails_helper'

describe Deal do

  it 'has a valid factory' do
    expect(build_stubbed(:deal)).to be_valid
  end

  it 'is invalid without a status' do
    expect(build_stubbed(:deal, status: nil)).to have(1).errors_on(:status)
  end

  it 'is invalid without a description' do
    expect(build_stubbed(:deal, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without a start date' do
    expect(build_stubbed(:deal, start_date: nil)).to have(1).errors_on(:start_date)
  end

  it 'is invalid without a end date' do
    expect(build_stubbed(:deal, end_date: nil)).to have(1).errors_on(:end_date)
  end

  it 'is invalid without a business' do
    expect(build_stubbed(:deal, business: nil)).to have(1).errors_on(:business_id)
  end

  it 'is invalid if the end date is before the start date' do
    expect(build_stubbed(:deal, end_date: Date.yesterday)).to have(1).errors_on(:end_date)
  end

  it 'is invalid if a day of the week is not selected' do
    expect(build_stubbed(:deal, friday: false, saturday: false)).to have(1).errors_on(:base)
  end

  it 'is associated with 2 locations' do
    expect(create(:deal_with_locations).locations.count).to eq(2)
  end

  it 'is associated with 2 location deals' do
    expect(create(:deal_with_locations).location_deals.count).to eq(2)
  end

  it "destroys the associated location deals" do
    deal = create(:deal)
    location_deal = create(:location_deal, :deal => deal)
    expect(LocationDeal.all).to include(location_deal)
    deal.destroy
    expect(LocationDeal.all).not_to include(location_deal)
  end

end