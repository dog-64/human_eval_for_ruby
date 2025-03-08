def double_the_difference(numbers)
  numbers.select { |n| n > 0 && n % 1 == 0 && n % 2 != 0 }.map { |n| n ** 2 }.sum
end