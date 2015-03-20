class SearchController < ApplicationController

  def index
    @business_search_form = BusinessSearchForm.new
    if @business_search_form.submit(params[:business_search_form])
      @location_deals = @business_search_form.results
    else
      render template: 'home/index'
    end
  end

end