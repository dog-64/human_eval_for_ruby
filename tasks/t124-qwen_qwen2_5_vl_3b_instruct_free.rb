def valid_date?(date_string)
  return false if date_string.empty?

  parts = date_string.split('-')
  return false if parts.length != 3

  month, day, year = parts.map(&:to_i)

  return false if month < 1 || month > 12
  return false if day < 1 || day > 31

  case month
  when 2
    return false if day > 29 unless year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
  when 4, 6, 9, 11
    return false if day > 30
  else
    return false if day > 31
  end

  true
end