
def remove_duplicates(numbers)
  count = Hash.new(0)
  numbers.each { |num| count[num] += 1 }
  numbers.select { |num| count[num] == 1 }
end