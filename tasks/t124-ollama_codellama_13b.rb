def valid_date?(date_string)
  date = Date.strptime(date_string, "%m-%d-%Y")
  return false unless date.valid?

  month, day, year = date.month, date.day, date.year
  if month == 2 && day > 28
    return false unless Date.leap?(year) && day <= 29
  elsif [4, 6, 9, 11].include?(month) && day > 30
    return false
  end

  true
end