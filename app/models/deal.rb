class Deal < ActiveRecord::Base
  enum status: [ :active, :disabled ] #DO NOT change this order

  has_many :location_deals, inverse_of: :deal, dependent: :destroy
  has_many :locations, :through => :location_deals
  belongs_to :business, inverse_of: :deals

  validates :status, :description, :start_date, :end_date, :business_id, presence: true
  validate :start_date_before_end_date, :at_least_one_location, :at_least_one_day_of_week

  def start_date_before_end_date
    if start_date.present? && end_date.present? && (end_date < start_date)
      errors.add :end_date, "needs to be after the start date"
    end
  end

  def at_least_one_location
    if location_deals.blank?
      errors.add :base, 'Please select a location'
    end
  end

  def at_least_one_day_of_week
    if monday.blank? && tuesday.blank? && wednesday.blank? && thursday.blank? &&
        friday.blank? && saturday.blank? && sunday.blank?
      errors.add :base, 'Please select at least one day of the week'
    end
  end

end