def remove_duplicates(numbers)
  unique_numbers = numbers.uniq
  numbers.zip(unique_numbers).map { |n, u| n if n == u }
end