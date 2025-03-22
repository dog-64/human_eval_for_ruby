def remove_duplicates(numbers)
  counts = Hash.new(0)
  numbers.each { |num| counts[num] += 1 }
  numbers.reject { |num| counts[num] > 1 }
end