def has_close_elements(numbers, threshold)
  numbers.each_with_index do |num, i|
    numbers[i + 1..-1].each do |next_num|
      if (num - next_num).abs <= threshold
        return true
      end
    end
  end
  false
end