require 'rails_helper'

describe Plan do

  it 'has a valid factory' do
    expect(build_stubbed(:plan)).to be_valid
  end

  it 'is invalid without a stripe plan id' do
    expect(build_stubbed(:plan, stripe_plan_id: nil)).to have(1).errors_on(:stripe_plan_id)
  end

  it 'is invalid without a description' do
    expect(build_stubbed(:plan, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without trial days' do
    expect(build_stubbed(:plan, trial_days: nil)).to have(1).errors_on(:trial_days)
  end

  it 'is invalid without an interval' do
    expect(build_stubbed(:plan, interval: nil)).to have(1).errors_on(:interval)
  end

  it 'is invalid without an active flag' do
    expect(build_stubbed(:plan, active: nil)).to have(1).errors_on(:active)
  end

  it 'is invalid without a unique stripe plan id' do
    plan = create(:plan)
    expect(build_stubbed(:plan, stripe_plan_id: plan.stripe_plan_id)).to have(1).errors_on(:stripe_plan_id)
  end

end