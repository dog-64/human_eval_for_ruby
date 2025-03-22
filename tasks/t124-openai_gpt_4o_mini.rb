def valid_date?(date_string)
  return false if date_string.empty? || !date_string.match?(/^\d{2}-\d{2}-\d{4}$/)

  month, day, year = date_string.split('-').map(&:to_i)

  return false if month < 1 || month > 12
  return false if day < 1 || day > days_in_month(month, year)

  true
end

def days_in_month(month, year)
  case month
  when 1, 3, 5, 7, 8, 10, 12
    31
  when 4, 6, 9, 11
    30
  when 2
    leap_year?(year) ? 29 : 28
  end
end

def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end