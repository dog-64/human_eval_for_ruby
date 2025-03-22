def sort_numbers(numbers)
  words = numbers.split
  return "" if words.empty?
  
  mapping = {
    "zero" => 0, "one" => 1, "two" => 2, "three" => 3, "four" => 4,
    "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9
  }

  sorted_words = words.map { |word| [mapping[word], word] }.sort.map(&:last)
  sorted_words.join(" ")
end
