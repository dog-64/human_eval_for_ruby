def sort_numbers(numbers)
  words = numbers.split
  words.sort_by { |word| %w[zero one two three four five six seven eight nine].index(word) }.join(' ')
end