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
      self.results.reject!(&:blank?)
      true
    else
      false
    end
  end

  private

  def find_search_results
    location_deal_ids = find_nearby_deals #these are in increasing distance order
    deals = LocationDeal.includes(:deal, :location => { :business => :category }).where(id: location_deal_ids)
    deals = deals.where(:businesses => { :category_id => category }) if category.present?
    deals = deals.where(:deals => { "#{day_of_week.downcase}" => true }) if day_of_week.present?
    deals = deals.active.current(day_of_week)
    location_deal_ids.map{ |id| deals.detect{ |deal| deal.id == id } } #put back in distance order
  end


  def find_nearby_deals
    location_deals = Location.near(location, distance, :select => "location_deals.*").joins(:location_deals)
    location_deals.map{ |location_deal| location_deal.id }
  end

end