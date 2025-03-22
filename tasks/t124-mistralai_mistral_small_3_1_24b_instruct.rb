require 'date'

def valid_date?(date_string)
  return false if date_string.empty?
  begin
    Date.strptime(date_string, '%m-%d-%Y')
    true
  rescue ArgumentError
    false
  end
end