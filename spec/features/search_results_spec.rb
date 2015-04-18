require 'rails_helper'

feature 'Search Results' do
  before(:each) do
    @category = create(:category)
    @category_two = create(:category)
    @business = create(:business, :category => @category)
    @deal = create(:deal, :end_date => 1.week.from_now.to_date, :business => @business)
    @location = create(:location, :business => @business)
    @location_deal = create(:location_deal, :location => @location, :deal => @deal)
    @business_two = create(:business, :category => @category)
    @deal_two = create(:deal, :end_date => 1.week.from_now.to_date, :business => @business_two)
    @location_two = create(:location, :business => @business_two)
    @location_deal_two = create(:location_deal, :location => @location_two, :deal => @deal_two)
  end

  scenario 'Searching for a deal that meets the search criteria' do
    visit root_path
    within("#new_business_search_form") do
      select @category.name, :from => 'business_search_form_category'
      select 'Any', :from => 'business_search_form_day_of_week'
      select '5 miles', :from => 'business_search_form_distance'
      fill_in 'Location', :with => 'Syosset, NY 11791'
    end

    click_button 'Search'
    expect(page).to have_content @business.name
    expect(page).to have_content @location.address
    expect(page).to have_content @deal.description
  end

  scenario 'Searching for a category that does not have any businesses with deals' do
    visit root_path
    within("#new_business_search_form") do
      select @category_two.name, :from => 'business_search_form_category'
      select 'Any', :from => 'business_search_form_day_of_week'
      select '5 miles', :from => 'business_search_form_distance'
      fill_in 'Location', :with => 'Syosset, NY 11791'
    end

    click_button 'Search'
    expect(page).to have_content 'There are currently no deals that match your search'
  end

  scenario 'Searching for a day of the week that has deals' do
    visit root_path
    within("#new_business_search_form") do
      select @category.name, :from => 'business_search_form_category'
      select 'Friday', :from => 'business_search_form_day_of_week'
      select '5 miles', :from => 'business_search_form_distance'
      fill_in 'Location', :with => 'Syosset, NY 11791'
    end

    click_button 'Search'
    expect(page).to have_content @business.name
    expect(page).to have_content @business_two.name
  end

  scenario 'Searching for a day of the week that does not have any deals' do
    visit root_path
    within("#new_business_search_form") do
      select @category.name, :from => 'business_search_form_category'
      select 'Monday', :from => 'business_search_form_day_of_week'
      select '5 miles', :from => 'business_search_form_distance'
      fill_in 'Location', :with => 'Syosset, NY 11791'
    end

    click_button 'Search'
    expect(page).to have_content 'There are currently no deals that match your search'
  end

  scenario 'Searching in a location that only has one deal' do
    @location_two.latitude = 0
    @location_two.longitude = 0
    @location_two.save(validate: false)

    visit root_path
    within("#new_business_search_form") do
      select @category.name, :from => 'business_search_form_category'
      select 'Any', :from => 'business_search_form_day_of_week'
      select '5 miles', :from => 'business_search_form_distance'
      fill_in 'Location', :with => 'Syosset, NY 11791'
    end

    click_button 'Search'
    expect(page).to have_content @business.name
    expect(page).not_to have_content @business_two.name
  end


end