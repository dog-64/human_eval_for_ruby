def sort_even_elements(list)
  even_elements = list.select.with_index { |_, i| i.even? }
  odd_elements = list.select.with_index { |_, i| i.odd? }
  sorted_even = even_elements.sort
  result = []
  sorted_even.each_with_index do |element, i|
    result << element
    result << odd_elements[i] if odd_elements[i]
  end
  result
end
