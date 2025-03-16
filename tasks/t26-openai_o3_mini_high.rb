def remove_duplicates(numbers)
  freq = numbers.each_with_object(Hash.new(0)) { |num, h| h[num] += 1 }
  numbers.select { |num| freq[num] == 1 }
end