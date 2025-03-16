def unique_digits(numbers)
  numbers.select { |n| n.to_s !~ /[02468]/ }.sort
end