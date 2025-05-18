def valid_date?(date_string)
  return false if date_string.empty?

  date_parts = date_string.split('-')
  return false unless date_parts.size == 3

  month, day, year = date_parts.map(&:to_i)

  return false unless month.between?(1, 12) && day.between?(1, 31)

  case month
  when 4, 6, 9, 11
    return false unless day.between?(1, 30)
  when 2
    if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
      return false unless day.between?(1, 29)
    else
      return false unless day.between?(1, 28)
    end
  end

  true
end