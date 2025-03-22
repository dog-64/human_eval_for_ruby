def sort_numbers(numbers)
  words = numbers.split
  sorted_words = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  index_map = Hash.new { |h, k| h[k] = [] }
  sorted_words.each_with_index do |word, i|
    index_map[word] << i
  end

  words.map do |word|
    index_map[word].sort.first
  end.join(' ')
end