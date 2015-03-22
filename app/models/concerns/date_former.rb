require 'chronic'

module DateFormer
  extend ActiveSupport::Concern

  def get_date_from_day(day)
    today = Date::DAYNAMES[Date.today.wday]
    if day.blank? || (today == day)
      Date.today
    else
      Chronic.parse("#{day}").to_date
    end
  end

  def upcoming_deal_days
    8.days
  end

end