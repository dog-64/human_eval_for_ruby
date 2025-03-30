
def valid_date?(date_string)
  return false unless date_string.match?(/\A\d{2}-\d{2}-\d{4}\z/)

  parts = date_string.split('-')
  return false unless parts.size == 3

  month = parts[0].to_i
  day = parts[1].to_i
  year = parts[2].to_i

  return false unless month.between?(1, 12)

  max_days = { 1=>31, 2=>28, 3=>31, 4=>30, 5=>31, 6=>30, 7=>31, 8=>31, 9=>30, 10=>31, 11=>30, 12=>31 }
  max_days[2] = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28 if month == 2

  day.between?(1, max_days[month])
end

 