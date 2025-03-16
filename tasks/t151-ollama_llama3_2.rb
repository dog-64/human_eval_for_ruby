def double_the_difference(numbers)
  numbers.select(&:odd?).map(&:to_i).select { |x| x > 0 }.sum { |x| x ** 2 }
end