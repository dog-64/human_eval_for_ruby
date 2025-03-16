def remove_duplicates(numbers)
  count = Hash.new(0)
  numbers.each { |number| count[number] += 1 }
  numbers.select { |number| count[number] == 1 }
end