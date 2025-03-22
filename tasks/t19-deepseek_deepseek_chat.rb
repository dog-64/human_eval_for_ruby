def sort_numbers(numbers)
  word_to_num = {
    'zero' => 0,
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }
  num_to_word = word_to_num.invert

  nums = numbers.split
  nums.sort_by! { |word| word_to_num[word] }
  nums.join(' ')
end