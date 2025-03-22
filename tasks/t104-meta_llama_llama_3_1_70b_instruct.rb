def unique_digits(numbers)
  numbers.select { |n| n.to_s.chars.all? { |c| c.to_i.odd? } }.sort
end