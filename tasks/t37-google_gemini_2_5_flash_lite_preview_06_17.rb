def sort_even_elements(list)
  even_elements = list.select.each_with_index { |_, index| index.even? }.sort
  result = []
  list.each_with_index do |element, index|
    if index.even?
      result << even_elements.shift
    else
      result << element
    end
  end
  result
end