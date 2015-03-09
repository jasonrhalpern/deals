class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: Devise::email_regexp }
  validates :password, presence: true, confirmation: true, length: { in: 6..20 }, if: :password_required?
  validate :password_complexity

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

end
