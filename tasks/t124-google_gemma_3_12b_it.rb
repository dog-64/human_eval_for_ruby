def valid_date?(date_string)
  return false if date_string.empty?

  parts = date_string.split('-')
  return false if parts.length != 3

  month, day, year = parts.map(&:to_i)

  return false if month < 1 || month > 12

  return false if day < 1

  case month
  when 4, 6, 9, 11
    return false if day > 30
  when 2
    if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
      return false if day > 29
    else
      return false if day > 28
    end
  else
    return false if day > 31
  end

  true
end
