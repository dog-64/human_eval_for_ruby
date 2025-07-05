def sort_numbers(numbers)
  word_to_digit = {
    'zero' => 0, 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4,
    'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9
  }
  digit_to_word = word_to_digit.invert
  
  numbers.split.sort_by { |word| word_to_digit[word] }.join(' ')
end