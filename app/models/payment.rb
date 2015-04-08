class Payment < ActiveRecord::Base
  belongs_to :business, inverse_of: :payment

  validates :stripe_cus_id, :stripe_sub_id, :active_until, :business_id, presence: true

end