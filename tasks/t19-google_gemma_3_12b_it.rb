def sort_numbers(numbers)
  number_mapping = {
    "zero": 0,
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9
  }

  if numbers.empty?
    return ""
  end

  numbers_array = numbers.split
  sorted_numbers_array = numbers_array.sort_by { |num| number_mapping[num] }
  sorted_numbers_array.join(" ")
end
