require 'rails_helper'

describe Favorite do

  it 'has a valid factory' do
    expect(build_stubbed(:favorite)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:favorite, user: nil)).to have(1).errors_on(:user_id)
  end

  it 'is invalid without a location' do
    expect(build_stubbed(:favorite, location: nil)).to have(1).errors_on(:location_id)
  end

  it 'is invalid is the user already has this location as a favorite' do
    favorite = create(:favorite)
    expect(build_stubbed(:favorite, user_id: favorite.user_id, location_id: favorite.location_id)).to have(1).errors_on(:user_id)
  end

end