def valid_date?(date_string)
  return false unless date_string.match?(/\A\d{2}-\d{2}-\d{4}\z/)

  month, day, year = date_string.split('-').map(&:to_i)
  return false if month < 1 || month > 12
  return false if day < 1

  days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_month[1] = 29 if (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0)

  day <= days_in_month[month - 1]
end