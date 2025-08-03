
unique_digits(numbers)
  numbers.select { |num| num.to_s.chars.all? { |d| d.to_i.odd? } }.sort
end