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

  it 'is invalid without an avatar' do
    expect(build_stubbed(:business, avatar: nil)).to have(1).errors_on(:avatar)
  end

  it 'is invalid without a category' do
    expect(build_stubbed(:business, category: nil)).to have(1).errors_on(:category_id)
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:business, user: nil)).to have(1).errors_on(:user_id)
  end

  it 'is invalid without a unique website' do
    biz = create(:business)
    expect(build_stubbed(:business, website: biz.website)).to have(1).errors_on(:website)
  end

  it 'is has 3 locations' do
    expect(create(:business_with_locations).locations.count).to eq(3)
  end

  it 'has 3 deals' do
    expect(create(:business_with_deals).deals.count).to eq(2)
  end

  describe 'active?' do
    it 'returns true if the business is active' do
      business = build(:business_with_active_payment)
      expect(business.active?).to be_truthy
    end

    it 'returns false if the business is not active' do
      business = build(:business_with_inactive_payment)
      expect(business.active?).to be_falsey
    end
  end

  describe 'pending?' do
    it 'returns true if the business is pending' do
      business = build(:business)
      expect(business.pending?).to be_truthy
    end

    it 'returns false if the business is not pending' do
      business = build(:business_with_active_payment)
      expect(business.pending?).to be_falsey
    end
  end

  describe 'canceled?' do
    it 'returns true if the business is canceled' do
      payment = build(:payment, :stripe_sub_token => nil)
      business = build(:business, :payment => payment)
      expect(business.canceled?).to be_truthy
    end

    it 'returns false if the business is not canceled' do
      payment = build(:payment)
      business = build(:business, :payment => payment)
      expect(business.canceled?).to be_falsey
    end
  end

  describe 'deactivated?' do
    it 'returns true if the business is deactivated' do
      business = build(:business_with_inactive_payment)
      expect(business.deactivated?).to be_truthy
    end

    it 'returns false if the business is active' do
      business = build(:business_with_active_payment)
      expect(business.deactivated?).to be_falsey
    end
  end

  it 'returns a list of businesses with active payments' do
    business1 = create(:business_with_active_payment)
    business2 = create(:business_with_inactive_payment)

    expect(Business.active).to eq([business1])
  end

end