class LocationDeal < ActiveRecord::Base
  belongs_to :location, inverse_of: :location_deals
  belongs_to :deal, inverse_of: :location_deals

  validates :location, :deal, presence: true
  validates :location_id, :uniqueness => { :scope => :deal_id }
end