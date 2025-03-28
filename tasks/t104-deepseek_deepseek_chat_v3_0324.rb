def unique_digits(numbers)
  numbers.select { |num| num.to_s.chars.none? { |d| d.to_i.even? } }.sort
end