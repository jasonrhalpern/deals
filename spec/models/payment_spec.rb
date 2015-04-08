require 'rails_helper'

describe Payment do

  it 'has a valid factory' do
    expect(build_stubbed(:payment)).to be_valid
  end

  it 'is invalid without a stripe customer id' do
    expect(build_stubbed(:payment, stripe_cus_id: nil)).to have(1).errors_on(:stripe_cus_id)
  end

  it 'is invalid without a stripe subscription id' do
    expect(build_stubbed(:payment, stripe_sub_id: nil)).to have(1).errors_on(:stripe_sub_id)
  end

  it 'is invalid without an active until time' do
    expect(build_stubbed(:payment, active_until: nil)).to have(1).errors_on(:active_until)
  end

  it 'is invalid without a business' do
    expect(build_stubbed(:payment, business: nil)).to have(1).errors_on(:business_id)
  end

end