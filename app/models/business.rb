class Business < ActiveRecord::Base
  belongs_to :category, inverse_of: :businesses
  belongs_to :user, inverse_of: :business


  validates :name, :category_id, :user_id, presence: true

end
