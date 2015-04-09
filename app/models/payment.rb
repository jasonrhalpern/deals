class Payment < ActiveRecord::Base
  belongs_to :business, inverse_of: :payment
  validates :stripe_cus_token, :stripe_sub_token, :active_until, :business_id, presence: true
  attr_accessor :stripe_card_token, :stripe_plan_token

  scope :active, -> { where('active_until > ?', Time.now) }

end