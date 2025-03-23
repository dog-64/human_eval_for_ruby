
def sort_numbers(numbers)
  number_map = {
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

  numbers_array = numbers.split
  sorted_numbers = numbers_array.sort_by { |number| number_map[number] }

  sorted_numbers.join(' ')
end
