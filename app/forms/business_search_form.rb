class BusinessSearchForm
  include ActiveModel::Model

  validates :location, :distance, presence: true

  attr_accessor :category, :day_of_week, :location, :distance, :results

  def submit(params)
    self.category = params[:category]
    self.day_of_week = params[:day_of_week]
    self.location = params[:location]
    self.distance = params[:distance]
    if valid?
      self.results = find_search_results
      true
    else
      false
    end
  end

  private

  def find_search_results

  end

end