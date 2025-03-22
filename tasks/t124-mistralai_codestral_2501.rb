require 'date'

def valid_date?(date_string)
  return false unless date_string =~ /\A\d{2}-\d{2}-\d{4}\z/

  begin
    Date.strptime(date_string, '%m-%d-%Y')
    true
  rescue ArgumentError
    false
  end
end