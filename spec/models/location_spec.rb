require 'rails_helper'

describe Location do

  it 'has a valid factory' do
    expect(build_stubbed(:location)).to be_valid
  end

  it 'is invalid without a street' do
    expect(build_stubbed(:location, street: nil)).to have(1).errors_on(:street)
  end

  it 'is invalid without a city' do
    expect(build_stubbed(:location, city: nil)).to have(1).errors_on(:city)
  end

  it 'is invalid without a state' do
    expect(build_stubbed(:location, state: nil)).to have(1).errors_on(:state)
  end

  it 'is invalid without a zip code' do
    expect(build_stubbed(:location, zip_code: nil)).to have(2).errors_on(:zip_code)
  end

  it 'is invalid without a zip code in the right format' do
    expect(build_stubbed(:location, zip_code: '123')).to have(1).errors_on(:zip_code)
  end

  it 'is invalid without a phone number' do
    expect(build_stubbed(:location, phone_number: nil)).to have(2).errors_on(:phone_number)
  end

  it 'is invalid without a phone number in the right format' do
    expect(build_stubbed(:location, phone_number: '213-1332')).to have(1).errors_on(:phone_number)
  end

  it 'is invalid without a business' do
    expect(build_stubbed(:location, business: nil)).to have(1).errors_on(:business_id)
  end

  it 'has a latitude' do
    expect(create(:location).latitude).not_to be_nil
  end

  it 'has a longitude' do
    expect(create(:location).longitude).not_to be_nil
  end

  it 'is associated with 3 locations' do
    expect(create(:location_with_deals).deals.count).to eq(3)
  end

  it 'is associated with 3 location deals' do
    expect(create(:location_with_deals).location_deals.count).to eq(3)
  end

  it 'has 3 favorites' do
    expect(create(:location_with_favorites).favorites.count).to eq(3)
  end

  it 'has been favorited by 3 users' do
    expect(create(:location_with_favorites).favorited.count).to eq(3)
  end

  it "destroys the associated location deals" do
    location = create(:location_with_deals)
    location_deal = create(:location_deal, :location => location)
    expect(LocationDeal.all).to include(location_deal)
    location.destroy
    expect(LocationDeal.all).not_to include(location_deal)
  end
end