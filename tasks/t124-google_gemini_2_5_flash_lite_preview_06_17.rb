def valid_date?(date_string)
  return false if date_string.nil? || date_string.empty?
  return false unless date_string.match?(/^\d{2}-\d{2}-\d{4}$/)

  month, day, year = date_string.split('-').map(&:to_i)

  return false if month < 1 || month > 12
  return false if day < 1 || day > 31

  days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  is_leap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
  days_in_month[2] = 29 if is_leap

  return false if day > days_in_month[month]

  true
end
