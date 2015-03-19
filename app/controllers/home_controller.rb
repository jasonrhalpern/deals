class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => []

  def index
    @business_search_form = BusinessSearchForm.new
  end

end
