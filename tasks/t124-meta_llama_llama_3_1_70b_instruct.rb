def valid_date?(date_string)
  return false if date_string.empty?

  month, day, year = date_string.split('-').map(&:to_i)
  return false if date_string.split('-').size!= 3 || date_string =~ /[a-zA-Z]/

  begin
    Date.new(year, month, day)
    true
  rescue ArgumentError
    false
  end
end