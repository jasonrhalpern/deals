class LocationDeal < ActiveRecord::Base
  belongs_to :location, inverse_of: :location_deals
  belongs_to :deal, inverse_of: :location_deals

  validates :location, :deal, presence: true
  validates :location_id, :uniqueness => { :scope => :deal_id }

  scope :active, -> { joins(:deal).where('deals.status = ?', Deal.statuses[:active]) }

  def self.current
    joins(:deal).where('deals.start_date <= ? AND ? <= deals.end_date', Date.today + 11.days, Date.today)
  end
end