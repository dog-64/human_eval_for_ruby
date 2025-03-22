def valid_date?(date_string)
  return false if date_string.empty?

  day, month, year = *date_string.split('-').map(&:to_i)

  return false if day < 1 || day > 31 ||
                  month < 1 || month > 12 ||
                  (month == 2 && (day != 29 || (year % 4 != 0 && year % 100 != 0 && year % 400 != 0))) ||
                  (month == 4 || month == 6 || month == 9 && day > 30) ||
                  (month == 3 && (day != 31 || (year % 4 != 0 && year % 100 != 0 && year % 400 != 0))))

  true
end