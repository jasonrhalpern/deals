class LocationDeal < ActiveRecord::Base
  belongs_to :location
  belongs_to :deal

  validates :location_id, presence: true, :uniqueness => { :scope => :deal_id }
end