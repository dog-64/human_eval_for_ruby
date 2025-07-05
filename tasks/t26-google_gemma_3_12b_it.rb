def remove_duplicates(numbers)
  seen = Set.new
  result = []
  numbers.each do |number|
    unless seen.include?(number)
      result << number
      seen.add(number)
    end
  end
  
  counts = Hash.new(0)
  numbers.each { |num| counts[num] += 1 }
  
  unique_numbers = []
  numbers.each_with_index do |num, index|
    if counts[num] == 1
      unique_numbers << num
    end
  end
  
  unique_numbers
end
