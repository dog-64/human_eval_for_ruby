def remove_duplicates(numbers)
  seen = {}
  result = []

  numbers.each do |number|
    unless seen[number]
      result << number
      seen[number] = true
    end
  end

  result
end
