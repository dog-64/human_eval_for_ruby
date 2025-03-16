require 'date'

def valid_date?(date_string)
  return false unless date_string.match?(/\A\d\d-\d\d-\d{4}\z/)
  month, day, year = date_string.split('-').map(&:to_i)
  return false unless (1..12).include?(month)
  begin
    Date.new(year, month, day)
    true
  rescue ArgumentError
    false
  end
end