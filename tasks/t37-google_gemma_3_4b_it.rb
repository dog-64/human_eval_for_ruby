def sort_even_elements(list)
  odd_elements = list[::0..-1].select { |_, i| i.odd? }
  even_elements = list[::0..-1].select { |_, i| i.even? }

  sorted_even_elements = even_elements.sort_by { |_, i| i }

  result = []
  odd_elements.each { |element, index| result << element }
  sorted_even_elements.each { |element, index| result << element }

  result
end
