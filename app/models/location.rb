class Location < ActiveRecord::Base
  geocoded_by :full_address
  has_many :location_deals, inverse_of: :location, dependent: :destroy
  has_many :deals, :through => :location_deals
  has_many :favorites, inverse_of: :location
  has_many :favorited, :through => :favorites, :source => :user
  belongs_to :business, inverse_of: :locations

  validates :street, :city, :state, :zip_code, :phone_number, :business_id, presence: true
  validates :zip_code, format: { with: /\A\d{5}-\d{4}|\A\d{5}\z/, message: "should be in the format 12345 or 12345-1234" }
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "should be in the format 123-456-7890" }

  after_validation :geocode

  def full_address
    [street, city, state, 'US', zip_code].compact.join(', ')
  end

  def address
    [street, city, state, zip_code].compact.join(', ')
  end
end
