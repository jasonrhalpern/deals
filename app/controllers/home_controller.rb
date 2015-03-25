class HomeController < ApplicationController
  before_action :authenticate_user!, :only => []

  def index
    @business_search_form = BusinessSearchForm.new
  end

end
