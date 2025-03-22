def valid_date?(date_string)
  return false unless date_string.match?(/^\d{2}-\d{2}-\d{4}$/)

  month, day, year = date_string.split('-').map(&:to_i)

  return false if month < 1 || month > 12
  return false if day < 1 || day > 31

  if month == 2
    if (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0)
      return false if day > 29
    else
      return false if day > 28
    end
  elsif [4, 6, 9, 11].include?(month)
    return false if day > 30
  end

  true
end