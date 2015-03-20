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
    nearby_deal_ids = find_nearby_deals #these are in the right distance order
    deals = Deal.includes(:locations, :business => :category).where(id: nearby_deal_ids)
    deals = deals.where(:businesses => {:category_id => category}) if category.present?
    nearby_deal_ids.map{|id| deals.detect{|deal| deal.id == id}}
  end


  def find_nearby_deals
    deals = Location.near(location, distance, :select => "deals.*").joins(:deals)
    deals = deals.where("deals.#{day_of_week.downcase}" => true) if day_of_week.present?
    deals.map{|deal| deal.id}
  end

end