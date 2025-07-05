def valid_date?(date_string)
  return false unless date_string =~ /\A(\d{2})-(\d{2})-(\d{4})\z/

  month = $1.to_i
  day = $2.to_i
  year = $3.to_i

  return false unless (1..12).include?(month)

  days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  if year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)
    days_in_month[2] = 29
  end

  return false unless (1..days_in_month[month]).include?(day)

  true
end