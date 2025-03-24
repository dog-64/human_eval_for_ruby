require 'date'

def valid_date?(date_string)
  return false unless date_string.match?(/\A(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d\z/)

  month, day, year = date_string.split('-').map(&:to_i)
  Date.new(year, month, day) rescue false
end