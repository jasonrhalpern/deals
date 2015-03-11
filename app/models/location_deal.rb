class LocationDeal < ActiveRecord::Base
  belongs_to :location
  belongs_to :deal

  validates :location_id, :deal_id, presence: true
  validates :location_id, :uniqueness => { :scope => :deal_id }
end