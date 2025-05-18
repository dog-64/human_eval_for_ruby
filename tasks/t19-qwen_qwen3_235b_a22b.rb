def sort_numbers(numbers)
  return '' if numbers.strip.empty?
  number_map = %w[zero one two three four five six seven eight nine].each_with_index.to_h
  words = numbers.split
  words.sort_by { |word| number_map[word] }.join(' ')
end