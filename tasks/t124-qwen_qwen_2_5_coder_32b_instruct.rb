def valid_date?(date_string)
  return false if date_string.empty?
  return false unless date_string.match?(/^\d{2}-\d{2}-\d{4}$/)

  month, day, year = date_string.split('-').map(&:to_i)
  return false unless (1..12).include?(month)

  Date.valid_civil?(year, month, day) rescue false
end