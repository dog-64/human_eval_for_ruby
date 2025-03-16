def sort_numbers(numbers)
  order = ["one", "three", "five", "seven", "eight", "nine", "zero", "two", "four", "six"]
  numbers.split.sort_by { |num| order.index(num) }.join(" ")
end