require 'rails_helper'

describe User do

  it 'has a valid factory' do
    expect(build_stubbed(:user)).to be_valid
  end

  it 'is invalid without a first name' do
    expect(build_stubbed(:user, first_name: nil)).to have(1).errors_on(:first_name)
  end

  it 'is invalid without a last name' do
    expect(build_stubbed(:user, last_name: nil)).to have(1).errors_on(:last_name)
  end

  it 'is invalid without an email' do
    expect(build_stubbed(:user, email: nil)).to have(2).errors_on(:email)
  end

  it 'is invalid without a valid email address' do
    expect(build_stubbed(:user, email: 'test.com')).to have(1).errors_on(:email)
  end

  it 'is invalid without a unique email' do
    create(:user, email: 'test@aol.com')
    expect(build_stubbed(:user, email: 'test@aol.com')).to have(1).errors_on(:email)
  end

  it 'is invalid without an avatar' do
    expect(build_stubbed(:user, avatar: nil)).to have(1).errors_on(:avatar)
  end

  it 'is invalid with a password that is too short' do
    expect(build_stubbed(:user, password: 'pw4$')).to have(1).errors_on(:password)
  end

  it 'is invalid with a password that is too long' do
    expect(build_stubbed(:user, password: 'w3#' * 7)).to have(1).errors_on(:password)
  end

  it 'is invalid with a password that doesn\'t have the right complexity' do
    expect(build_stubbed(:user, password: 'password')).to have(1).errors_on(:password)
  end

  it 'does not have a role' do
    expect(create(:user).roles.count).to eq(0)
  end

  it 'has an admin role' do
    expect(create(:admin).roles.count).to eq(1)
  end

  it 'is has a business' do
    expect(create(:user_with_business).business.name).to start_with('A Pizza Joint')
  end

  it 'has 2 favorites' do
    expect(create(:user_with_favorites).favorites.count).to eq(2)
  end

  it 'has 2 favorite businesses' do
    expect(create(:user_with_favorites).favorite_businesses.count).to eq(2)
  end

end
