require 'rails_helper'

describe Favorite do

  it 'has a valid factory' do
    expect(build_stubbed(:favorite)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:favorite, user: nil)).to have(1).errors_on(:user_id)
  end

  it 'is invalid without a business' do
    expect(build_stubbed(:favorite, business: nil)).to have(1).errors_on(:business_id)
  end

end