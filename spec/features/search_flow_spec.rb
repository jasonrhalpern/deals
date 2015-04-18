require 'rails_helper'

feature 'Search Flow' do
  include DealsHelper

  before(:each) do
    @category = create(:category)
    @business = create(:business, :category => @category)
    @deal_one = create(:deal, :description => 'this deal rocks', :end_date => 1.week.from_now.to_date, :business => @business)
    @location_one = create(:location, :city => 'Woodbury', :zip_code => '11797', :business => @business)
    @location_deal_one = create(:location_deal, :location => @location_one, :deal => @deal_one)
    @deal_two = create(:deal, :monday => true, :end_date => 1.week.from_now.to_date, :business => @business)
    @location_two = create(:location, :business => @business)
    @location_deal_two = create(:location_deal, :location => @location_two, :deal => @deal_two)
    @deal_three = create(:deal, :description => 'free oysters', :end_date => 2.weeks.from_now.to_date, :business => @business)
    @location_deal_three = create(:location_deal, :location => @location_two, :deal => @deal_three)
  end

  scenario 'Searching for a deal and visiting the location profiles of a specific business' do
    visit root_path
    within("#new_business_search_form") do
      select @category.name, :from => 'business_search_form_category'
      select 'Monday', :from => 'business_search_form_day_of_week'
      select '5 miles', :from => 'business_search_form_distance'
      fill_in 'Location', :with => 'Syosset, NY 11791'
    end
    click_button 'Search'
    expect(page).to have_content @business.name
    expect(page).to have_content @location_two.address
    expect(page).to have_content @deal_two.description
    expect(page).to have_content display_full_date(@deal_two.start_date)
    expect(page).to have_content display_full_date(@deal_two.end_date)
    expect(page).to have_content display_days(@deal_two)
    expect(page).not_to have_content @location_one.address
    expect(page).not_to have_content @deal_one.description
    expect(page).not_to have_content @deal_three.description

    click_link 'View All Deals'
    expect(page).to have_content @business.name
    expect(page).to have_content @location_two.address
    expect(page).to have_content @deal_two.description
    expect(page).to have_content display_full_date(@deal_two.start_date)
    expect(page).to have_content display_full_date(@deal_two.end_date)
    expect(page).to have_content display_days(@deal_two)
    expect(page).to have_content @deal_three.description
    expect(page).to have_content display_full_date(@deal_three.start_date)
    expect(page).to have_content display_full_date(@deal_three.end_date)
    expect(page).to have_content display_days(@deal_three)
    expect(page).to have_content 'Other Locations'
    expect(page).to have_content @location_one.address
    expect(page).not_to have_content @deal_one.description

    visit profile_business_path(@business, { :lid => @location_one.id })
    expect(page).to have_content @business.name
    expect(page).to have_content @location_one.address
    expect(page).to have_content @deal_one.description
    expect(page).to have_content display_full_date(@deal_one.start_date)
    expect(page).to have_content display_full_date(@deal_one.end_date)
    expect(page).to have_content display_days(@deal_one)
    expect(page).to have_content 'Other Locations'
    expect(page).to have_content @location_two.address
    expect(page).not_to have_content @deal_two.description
    expect(page).not_to have_content @deal_three.description
  end

end