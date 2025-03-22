def valid_date?(date_string)
  return false if date_string.empty?

  begin
    mm, dd, yyyy = date_string.split('-').map(&:to_i)
    return false unless date_string =~ /^\d{2}-\d{2}-\d{4}$/

    return false unless (1..12).include?(mm)

    days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    days_in_month[2] = 29 if (yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0

    return false unless (1..days_in_month[mm]).include?(dd)

    true
  rescue
    false
  end
end
