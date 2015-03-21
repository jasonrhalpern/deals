module DealsHelper

  def display_days(deal)
    days_of_week = []
    days_of_week << 'Monday' if deal.monday
    days_of_week << 'Tuesday' if deal.tuesday
    days_of_week << 'Wednesday' if deal.wednesday
    days_of_week << 'Thursday' if deal.thursday
    days_of_week << 'Friday' if deal.friday
    days_of_week << 'Saturday' if deal.saturday
    days_of_week << 'Sunday' if deal.sunday
    days_of_week.join(", ")
  end

  def display_full_date(date)
    date.to_formatted_s :long_ordinal
  end

end