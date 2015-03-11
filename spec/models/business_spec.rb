require 'rails_helper'

describe Business do

  it 'has a valid factory' do
    expect(build_stubbed(:business)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build_stubbed(:business, name: nil)).to have(1).errors_on(:name)
  end

  it 'is invalid without a website' do
    expect(build_stubbed(:business, website: nil)).to have(1).errors_on(:website)
  end

  it 'is invalid without a category' do
    expect(build_stubbed(:business, category: nil)).to have(1).errors_on(:category_id)
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:business, user: nil)).to have(1).errors_on(:user_id)
  end

  it 'is has 3 locations' do
    expect(create(:business_with_locations).locations.count).to eq(3)
  end

  it 'has 3 favorites' do
    expect(create(:business_with_favorites).favorites.count).to eq(3)
  end

  it 'has been favorited by 3 users' do
    expect(create(:business_with_favorites).favorited.count).to eq(3)
  end

end