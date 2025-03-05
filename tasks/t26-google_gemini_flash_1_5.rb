def remove_duplicates(numbers)
  seen = {}
  result = []
  numbers.each do |number|
    if !seen[number]
      seen[number] = true
      result << number
    end
  end
  result
end
