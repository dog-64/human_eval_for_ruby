def sort_numbers(numbers)
  number_words = {
    "zero" => 0, "one" => 1, "two" => 2, "three" => 3, "four" => 4,
    "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9
  }

  sorted_numbers = numbers.split.sort_by { |word| number_words[word] }
  sorted_numbers.join(' ')
end