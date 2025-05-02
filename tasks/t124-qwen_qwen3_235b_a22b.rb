def valid_date?(date_string)
  return false unless date_string.match?(/^(\d{2})-(\d{2})-(\d{4})$/)
  month = $1.to_i
  day = $2.to_i
  year = $3.to_i
  return false if month < 1 || month > 12
  days_in_month = case month
  when 2
    (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28
  when 4, 6, 9, 11
    30
  else
    31
  end
  day >= 1 && day <= days_in_month
end