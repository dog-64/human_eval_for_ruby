def valid_date?(date_string)
  return false unless date_string.is_a?(String) && date_string.match?(/\A\d{2}-\d{2}-\d{4}\z/)
  month_str, day_str, year_str = date_string.split('-')
  month = month_str.to_i
  day = day_str.to_i
  year = year_str.to_i
  return false unless month.between?(1, 12) && day >= 1
  leap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
  days_in_month = [31, leap ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  day <= days_in_month[month - 1]
end