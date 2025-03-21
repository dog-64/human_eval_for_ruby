def valid_date?(date_string)
  return false if date_string.empty?
  month, day, year = date_string.split('-').map(&:to_i)
  return false unless (1..12).include?(month) && (1..31).include?(day) && year >= 0
  return true if month == 2 && day == 29 && year % 4 == 0
  return false if month == 2 && day == 29
  true
end