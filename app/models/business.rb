class Business < ActiveRecord::Base
  has_many :locations, inverse_of: :business
  belongs_to :category, inverse_of: :businesses
  belongs_to :user, inverse_of: :business

  validates :name, :website, :category_id, :user_id, presence: true
end
