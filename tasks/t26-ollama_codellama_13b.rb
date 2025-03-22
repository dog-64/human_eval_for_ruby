def remove_duplicates(numbers)
  seen = Set.new
  numbers.select { |num| seen.add?(num) }
end