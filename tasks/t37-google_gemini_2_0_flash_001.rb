def sort_even_elements(list)
  even_elements = []
  odd_elements = []
  
  list.each_with_index do |element, index|
    if index.even?
      even_elements << element
    else
      odd_elements << element
    end
  end
  
  even_elements.sort!
  
  result = []
  even_index = 0
  odd_index = 0
  
  list.length.times do |i|
    if i.even?
      if even_index < even_elements.length
        result << even_elements[even_index]
        even_index += 1
      end
    else
      if odd_index < odd_elements.length
        result << list[i]
        odd_index += 1
      end
    end
  end
  
  return result
end