def sort_numbers(numbers)
  words = %w[zero one two three four five six seven eight nine]
  numbers.split.sort_by { |n| words.index(n) }.join(' ')
end