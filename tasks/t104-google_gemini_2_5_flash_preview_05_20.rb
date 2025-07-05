def unique_digits(numbers)
  numbers.select do |num|
    num.to_s.chars.all? { |digit| digit.to_i.odd? }
  end.sort
end