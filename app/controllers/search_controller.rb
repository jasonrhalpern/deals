class SearchController < ApplicationController
  before_action :authenticate_user!, :only => []

  def index
    @business_search_form = BusinessSearchForm.new
    if @business_search_form.submit(params[:business_search_form])
      @location_deals = @business_search_form.results
      @favorite_locations = Favorite.where(user_id: current_user.id).pluck(:location_id) if user_signed_in?
    else
      render template: 'home/index'
    end
  end

end