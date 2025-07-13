def valid_date?(date_string)
  return false unless date_string.match?(/\A\d{2}-\d{2}-\d{4}\z/)
  
  month, day, year = date_string.split('-').map(&:to_i)
  
  return false unless month.between?(1, 12)
  
  days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  
  if year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)
    days_in_month[1] = 29
  end
  
  day.between?(1, days_in_month[month - 1])
end