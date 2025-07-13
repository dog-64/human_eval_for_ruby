def sort_even_elements(list)
  return [] if list.empty?
  
  even_elements = list.each_with_index.select { |_, index| index.even? }.map(&:first)
  sorted_even = even_elements.sort
  
  result = list.dup
  even_index = 0
  
  result.each_with_index do |_, index|
    if index.even?
      result[index] = sorted_even[even_index]
      even_index += 1
    end
  end
  
  result
end