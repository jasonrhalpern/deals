require 'rails_helper'

describe Business do

  it 'has a valid factory' do
    expect(build_stubbed(:business)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build_stubbed(:business, name: nil)).to have(1).errors_on(:name)
  end

  it 'is invalid without a category' do
    expect(build_stubbed(:business, category_id: nil)).to have(1).errors_on(:category_id)
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:business, user_id: nil)).to have(1).errors_on(:user_id)
  end

end