def valid_date?(date_string)
  return false if date_string.empty?
  match = date_string.match(/(\d{2})-(\d{2})-(\d{4})/)
  return false unless match

  month = match[1].to_i
  day = match[2].to_i
  year = match[3].to_i

  return false unless (1..12).include?(month)
  return false unless (1..31).include?(day)

  begin
    Date.new(year, month, day)
    true
  rescue ArgumentError
    false
  end
end