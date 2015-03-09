require 'rails_helper'

describe Category do

  it 'has a valid factory' do
    expect(build_stubbed(:category)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build_stubbed(:category, name: nil)).to have(1).errors_on(:name)
  end

  it 'is invalid without a unique name' do
    create(:category, name: 'Restaurants')
    expect(build_stubbed(:category, name: 'Restaurants')).to have(1).errors_on(:name)
  end

  it 'is associated with 2 businesses' do
    expect(create(:category_with_businesses).businesses.count).to eq(2)
  end

end