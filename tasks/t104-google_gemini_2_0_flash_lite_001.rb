def unique_digits(numbers)
  numbers.select { |number| number.to_s.chars.all? { |digit| digit.to_i.odd? } }.sort
end