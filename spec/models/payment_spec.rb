require 'rails_helper'

describe Payment do

  it 'has a valid factory' do
    expect(build_stubbed(:payment)).to be_valid
  end

  it 'is invalid without a stripe customer token' do
    expect(build_stubbed(:payment, stripe_cus_token: nil)).to have(1).errors_on(:stripe_cus_token)
  end

  it 'is invalid without a stripe subscription id' do
    expect(build_stubbed(:payment, stripe_sub_token: nil)).to have(1).errors_on(:stripe_sub_token)
  end

  it 'is invalid without an active until time' do
    expect(build_stubbed(:payment, active_until: nil)).to have(1).errors_on(:active_until)
  end

  it 'is invalid without a business' do
    expect(build_stubbed(:payment, business: nil)).to have(1).errors_on(:business_id)
  end

  it 'returns an array of active payments' do
    deal1 = create(:payment, :active_until => 1.day.ago)
    deal2 = create(:payment, :active_until => 1.day.from_now)
    deal3 = create(:payment, :active_until => 1.month.from_now)
    expect(Payment.active).to eq([deal2, deal3])
  end

end