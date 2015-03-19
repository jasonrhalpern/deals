require 'rails_helper'

describe BusinessSearchForm do

  it 'has a valid factory' do
    expect(build(:business_search_form)).to be_valid
  end

  it 'is invalid without a location' do
    expect(build(:business_search_form, :location => nil)).not_to be_valid
  end

  it 'is invalid without a distance' do
    expect(build(:business_search_form, :distance => nil)).not_to be_valid
  end

end