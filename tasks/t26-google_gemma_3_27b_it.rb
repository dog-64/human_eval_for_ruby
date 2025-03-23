
def remove_duplicates(numbers)
  counts = Hash.new(0)
  numbers.each { |number| counts[number] += 1 }
  result = []
  numbers.each { |number| result << number if counts[number] == 1 }
  result
end
