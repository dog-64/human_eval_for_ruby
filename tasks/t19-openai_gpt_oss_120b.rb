def sort_numbers(numbers)
  mapping = {
    'zero' => 0, 'one' => 1, 'two' => 2, 'three' => 3,
    'four' => 4, 'five' => 5, 'six' => 6, 'seven' => 7,
    'eight' => 8, 'nine' => 9
  }
  words = numbers.strip.split
  return '' if words.empty?
  sorted = words.sort_by { |w| mapping[w] }
  sorted.join(' ')
end