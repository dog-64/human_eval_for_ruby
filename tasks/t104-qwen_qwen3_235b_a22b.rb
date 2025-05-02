def unique_digits(numbers)
  numbers.select { |n| n.to_s.chars.map(&:to_i).none?(&:even?) }.sort
end