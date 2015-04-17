class Business < ActiveRecord::Base
  has_many :locations, inverse_of: :business
  has_many :deals, inverse_of: :business
  belongs_to :category, inverse_of: :businesses
  belongs_to :user, inverse_of: :business
  has_one :payment, inverse_of: :business
  has_attached_file :avatar,
                    #:styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => "assets-localstoo";

  validates :name, :website, :category_id, :user_id, presence: true
  validates :website, uniqueness: true
  validates :avatar,
            presence: true,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 2.megabytes }

  def self.active
    joins(:payment).where('payments.active_until > ?', Time.now)
  end

  def active?
    payment.present? && payment.stripe_sub_token.present? && (payment.active_until > Time.now)
  end

  def pending?
    payment.nil?
  end

  def canceled?
    payment.present? && payment.stripe_sub_token.blank?
  end

  def deactivated?
    payment.present? && payment.stripe_sub_token.present? && (payment.active_until < Time.now)
  end


end
