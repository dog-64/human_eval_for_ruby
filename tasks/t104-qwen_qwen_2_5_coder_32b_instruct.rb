def unique_digits(numbers)
  numbers.select { |num| num.to_s.chars.all? { |digit| (digit.to_i.odd?) } }.sort
end