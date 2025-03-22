def valid_date?(date_string)
  return false if date_string.empty?

  begin
    month, day, year = date_string.split('-').map(&:to_i)
  rescue
    return false
  end

  return false if month.nil? || day.nil? || year.nil?

  return false unless date_string =~ /\A\d{2}-\d{2}-\d{4}\z/
  return false unless month >= 1 && month <= 12

  days_in_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_month[2] = 29 if Date.leap?(year)

  return false unless day >= 1 && day <= days_in_month[month]

  true
rescue
  false
end