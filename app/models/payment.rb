class Payment < ActiveRecord::Base
  belongs_to :business, inverse_of: :payment
  validates :stripe_cus_token, :stripe_sub_token, :active_until, :business_id, presence: true
  validates :business_id, uniqueness: true
  attr_accessor :stripe_card_token, :stripe_plan_token

  PAYMENT_EXCEPTIONS = [ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, Stripe::CardError,
                        Stripe::InvalidRequestError, Stripe::AuthenticationError, Stripe::APIConnectionError,
                        Stripe::APIError, Stripe::StripeError].freeze

  scope :active, -> { where('active_until > ?', Time.now) }

  def save_with_plan
    plan = Plan.where(stripe_plan_token: stripe_plan_token).first
    self.active_until = "#{plan.trial_days}".to_i.days.from_now
    customer = Stripe::Customer.create(
        :email => business.user.email,
        :source  => stripe_card_token,
        :plan => stripe_plan_token,
        :description => 'Registered Business'
    )
    self.stripe_cus_token = customer.id
    self.stripe_sub_token = customer.subscriptions.first.id
    save!
  rescue *PAYMENT_EXCEPTIONS => e
    logger.error "Stripe error while creating customer: #{e.message}"
    false
  end

end