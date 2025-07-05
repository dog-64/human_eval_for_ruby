def valid_date?(date_string)
  return false if date_string.empty?

  parts = date_string.split('-')

  return false if parts.length != 3

  month = parts[0].to_i
  day = parts[1].to_i
  year = parts[2].to_i

  return false if month < 1 || month > 12

  return false if day < 1 || day > 31

  days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
    days_in_month[2] = 29
  end

  return false if day > days_in_month[month]

  true
end
