class User < ActiveRecord::Base
  has_one :business, inverse_of: :user
  has_many :user_roles
  has_many :roles, :through => :user_roles
  has_many :favorites
  has_many :favorite_businesses, :through => :favorites, :source => :business
  has_attached_file :avatar,
                    #:styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => "assets-localstoo";

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: Devise::email_regexp }
  validates :password, presence: true, confirmation: true, length: { in: 6..20 }, if: :password_required?
  validate :password_complexity
  validates :avatar,
            presence: true,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 2.megabytes }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable

  def password_complexity
    if password.present? and not password.match(/^(?=.*[\d[!@#$%\^*()_\-=?|;:.,<>]])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%\^*()_\-=?|;:.,<>]*$/)
      errors.add :password, 'Invalid password. Passwords must be 6-20 characters and contain at least one letter and one number or special character.'
    end
  end

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
end
