def unique_digits(numbers)
  numbers.select { |num| num.to_s.chars.none? { |char| char.to_i.even? } }.sort
end