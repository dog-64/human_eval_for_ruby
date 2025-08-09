def remove_duplicates(numbers)
  counts = Hash.new(0)
  numbers.each { |n| counts[n] += 1 }
  numbers.select { |n| counts[n] == 1 }
end