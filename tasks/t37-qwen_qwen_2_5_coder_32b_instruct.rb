def sort_even_elements(list)
  even_index_elements = list.each_index.select { |i| i.even? }.map { |i| list[i] }.sort
  result = []
  even_index = 0
  list.each_index do |i|
    if i.even?
      result << even_index_elements[even_index]
      even_index += 1
    else
      result << list[i]
    end
  end
  result
end