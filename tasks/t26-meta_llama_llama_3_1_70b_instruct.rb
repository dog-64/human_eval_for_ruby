def remove_duplicates(numbers)
  numbers.select { |n| numbers.count(n) == 1 }
end