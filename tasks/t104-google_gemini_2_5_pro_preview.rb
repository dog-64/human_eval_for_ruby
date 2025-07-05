
 issue if it were allowed, but input is positive integers.
  # Smallest positive integer is 1.
  return false if number <= 0 # Though problem states positive integers, gooddef unique_digits(numbers)
  return [] if numbers.nil? || numbers.empty?

  result = numbers.select do |number|
    next