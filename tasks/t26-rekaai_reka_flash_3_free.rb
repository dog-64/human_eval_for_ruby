
def remove_duplicates(numbers)
  counts = numbers.each_with_object(Hash.new(0)) { |n, acc| acc[n] += 1 }
  numbers.select { |n| counts[n] == 1 }
end

 