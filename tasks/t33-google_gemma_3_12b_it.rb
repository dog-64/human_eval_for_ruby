def sort_third(l)
  if l.empty?
    return []
  end

  third_elements = []
  other_elements = []

  l.each_with_index do |element, index|
    if (index + 1) % 3 == 0
      third_elements << element
    else
      other_elements << element
    end
  end

  sorted_third_elements = third_elements.sort

  result = []
  index = 0
  third_index = 0

  l.each_with_index do |element, i|
    if (i + 1) % 3 == 0
      result << sorted_third_elements[third_index]
      third_index += 1
    else
      result << element
    end
  end

  result
end
