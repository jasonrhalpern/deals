class LocationDeal < ActiveRecord::Base
  extend DateFormer
  belongs_to :location, inverse_of: :location_deals
  belongs_to :deal, inverse_of: :location_deals

  validates :location, :deal, presence: true
  validates :location_id, :uniqueness => { :scope => :deal_id }

  def self.active
    joins(:deal).where('deals.status = ?', Deal.statuses[:active])
  end

  def self.current(day_of_week)
    day = get_date_from_day(day_of_week)
    joins(:deal).where('deals.start_date <= ? AND ? <= deals.end_date', day + upcoming_deal_period, day)
  end

  def self.upcoming
    joins(:deal).where('? <= deals.end_date', Date.today)
  end
end