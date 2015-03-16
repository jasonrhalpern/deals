class Favorite < ActiveRecord::Base
  belongs_to :user, inverse_of: :favorites
  belongs_to :location, inverse_of: :favorites

  validates :user_id, :location_id, presence: true
end