def sort_third(l)
  third_elements = []
  l.each_with_index do |element, index|
    third_elements << element if index % 3 == 0
  end
  sorted_third_elements = third_elements.sort
  result = []
  sorted_index = 0
  l.each_with_index do |element, index|
    if index % 3 == 0
      result << sorted_third_elements[sorted_index]
      sorted_index += 1
    else
      result << element
    end
  end
  result
end