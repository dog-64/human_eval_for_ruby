def has_close_elements(numbers, threshold)
  return false if numbers.nil? || numbers.length < 2

  sorted_numbers = numbers.sort

  sorted_numbers.each_with_index do |num, index|
    next if index == sorted_numbers.length - 1
    return true if (sorted_numbers[index + 1] - num).abs <= threshold
  end

  false
end