def unique_digits(numbers)
  numbers.select { |num| num.digits.all? { |d| d.odd? } }.sort
end