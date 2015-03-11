require 'rails_helper'

describe LocationDeal do

  it 'has a valid factory' do
    expect(build_stubbed(:location_deal)).to be_valid
  end

  it 'is invalid without a location' do
    expect(build_stubbed(:location_deal, location: nil)).to have(1).errors_on(:location_id)
  end

  it 'is invalid without a deal' do
    expect(build_stubbed(:location_deal, deal: nil)).to have(1).errors_on(:deal_id)
  end

  it 'is invalid if the deal is already associated with this location' do
    location_deal1 = create(:location_deal)
    expect(build_stubbed(:location_deal, location_id: location_deal1.location_id, deal_id: location_deal1.deal_id)).to have(1).errors_on(:location_id)
  end

end