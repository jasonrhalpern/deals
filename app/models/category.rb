class Category  < ActiveRecord::Base
  has_many :businesses, inverse_of: :category

  validates :name, presence: true, uniqueness: true
end