def double_the_difference(numbers)
  even_squares = numbers.select { |n| n % 2 == 0 }.map { |n| n ** 2 }
  odd_squares = numbers.select { |n| n % 2 != 0 }.map { |n| n ** 2 }
  (even_squares + odd_squares).sum
end