def remove_duplicates(numbers)
  counts = Hash.new(0)
  numbers.each { |number| counts[number] += 1 }
  numbers.select { |number| counts[number] == 1 }
end