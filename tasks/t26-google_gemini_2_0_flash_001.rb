def remove_duplicates(numbers)
  counts = Hash.new(0)
  numbers.each do |number|
    counts[number] += 1
  end

  result = []
  numbers.each do |number|
    if counts[number] == 1
      result << number
    end
  end

  return result
end