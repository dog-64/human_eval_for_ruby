def sort_third(l)
  return [] if l.empty?

  third_elements = []
  l.each_with_index do |item, index|
    third_elements << item if (index + 1) % 3 == 0
  end

  sorted_third_elements = third_elements.sort
  
  result = []
  sorted_index = 0
  l.each_with_index do |item, index|
    if (index + 1) % 3 == 0
      result << sorted_third_elements[sorted_index]
      sorted_index += 1
    else
      result << item
    end
  end
  result
end