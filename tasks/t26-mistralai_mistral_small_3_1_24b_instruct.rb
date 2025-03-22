def remove_duplicates(numbers)
  seen = {}
  result = []

  numbers.each do |number|
    if seen[number]
      seen[number] += 1
    else
      seen[number] = 1
      result << number
    end
  end

  result
end