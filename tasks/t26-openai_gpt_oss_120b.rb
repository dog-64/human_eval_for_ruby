def remove_duplicates(numbers)
  freq = Hash.new(0)
  numbers.each { |n| freq[n] += 1 }
  numbers.select { |n| freq[n] == 1 }
end