
def valid_date?(date_string)
  return false if date_string.empty?

  parts = date_string.split('-')
  return false unless parts.size == 3

  month_str, day_str, year_str = parts
  return false unless month_str.match?(/^\d{2}$/) && day_str.match?(/^\d{2}$/) && year_str.match?(/^\d{4}$/)

  month = month_str.to_i
  day = day_str.to_i
  year = year_str.to_i

  return false if month < 1 || month > 12
  return false if day < 1

  days_in_month = case month
                  when 1, 3, 5, 7, 8, 10, 12
                    31
                  when 4, 6, 9, 11
                    30
                  when 2
                    leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
                    leap_year ? 29 : 28
                  end

  day <= days_in_month
end