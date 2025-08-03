
def sort_even_elements(list)
  even_elements = list.select.with_index { |_, i| i.even? }
  sorted_evens = even_elements.sort
  list.map.with_index do |elem, i|
    i.even? ? sorted_evens[i / 2] : elem
  end
end