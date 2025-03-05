def has_close_elements(numbers, threshold)
  numbers.each_with_index do |num, i|
    numbers[i+1..-1].each do |other_num|
      return true if (num - other_num).abs <= threshold
    end
  end
  false
end