class SearchController < ApplicationController
  before_filter :authenticate_user!, :only => []

  def index
    @business_search_form = BusinessSearchForm.new
    if @business_search_form.submit(params[:business_search_form])
      @location_deals = @business_search_form.results
    else
      render template: 'home/index'
    end
  end

end