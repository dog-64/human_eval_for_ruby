def unique_digits(numbers)
  numbers.select { |number| number.to_s.chars.all? { |char| char.to_i % 2 == 1 } }.sort
end