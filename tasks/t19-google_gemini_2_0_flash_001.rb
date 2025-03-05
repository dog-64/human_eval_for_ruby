def sort_numbers(numbers)
  word_to_num = {
    "zero" => 0, "one" => 1, "two" => 2, "three" => 3, "four" => 4,
    "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9
  }

  num_to_word = word_to_num.invert

  number_words = numbers.split

  sorted_numbers = number_words.map { |word| word_to_num[word] }.sort

  sorted_numbers.map { |num| num_to_word[num] }.join(" ")
end