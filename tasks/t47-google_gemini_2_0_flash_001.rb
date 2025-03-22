def median(numbers)
  if numbers.empty?
    return nil
  end

  numbers.each do |num|
    unless num.is_a?(Numeric)
      raise ArgumentError, "List contains non-numeric values"
    end
  end

  sorted_numbers = numbers.sort
  list_length = sorted_numbers.length

  if list_length.odd?
    return sorted_numbers[list_length / 2].to_f
  else
    middle_index_1 = list_length / 2 - 1
    middle_index_2 = list_length / 2
    return (sorted_numbers[middle_index_1] + sorted_numbers[middle_index_2]) / 2.0
  end
end