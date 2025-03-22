def sort_third(l)
  third_elements = []
  result = []
  l.each_with_index do |element, index|
    if (index + 1) % 3 == 0
      third_elements << element
    else
      result << element
    end
  end
  third_elements.sort!
  third_index = 0
  result.each_with_index do |element, index|
    if (index + 1) % 3 == 0
      result[index] = third_elements[third_index]
      third_index += 1
    end
  end
  result
end
