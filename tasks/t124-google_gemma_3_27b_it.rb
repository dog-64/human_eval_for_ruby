
def valid_date?(date_string)
  return false if date_string.empty?

  match = date_string.match(/(\d{2})-(\d{2})-(\d{4})/)
  return false unless match

  month = match[1].to_i
  day = match[2].to_i
  year = match[3].to_i

  return false unless (1..12).include?(month)

  days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_month[2] = 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

  return false unless (1..days_in_month[month]).include?(day)

  true
end
