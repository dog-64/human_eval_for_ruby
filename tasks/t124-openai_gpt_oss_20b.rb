def valid_date?(date_string)
  return false if date_string.nil? || date_string.empty?
  match = /\A(\d{2})-(\d{2})-(\d{4})\z/.match(date_string)
  return false unless match
  month = match[1].to_i
  day   = match[2].to_i
  year  = match[3].to_i
  return false unless month.between?(1, 12)
  days_in_month = case month
                  when 1, 3, 5, 7, 8, 10, 12
                    31
                  when 4, 6, 9, 11
                    30
                  when 2
                    leap = (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
                    leap ? 29 : 28
                  end
  day.between?(1, days_in_month)
end