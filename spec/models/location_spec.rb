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
end