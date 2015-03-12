class Business < ActiveRecord::Base
  has_many :locations, inverse_of: :business
  has_many :deals, inverse_of: :business
  has_many :favorites
  has_many :favorited, :through => :favorites, :source => :user
  belongs_to :category, inverse_of: :businesses
  belongs_to :user, inverse_of: :business
  has_attached_file :avatar,
                    #:styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => "assets-localstoo";

  validates :name, :website, :category_id, :user_id, presence: true
  validates :avatar,
            presence: true,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 2.megabytes }
end
