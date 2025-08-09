def sort_even_elements(list)
  result = list.dup
  even_values = list.each_with_index.map { |v, i| v if i.even? }.compact
  even_values.sort!
  result.each_with_index do |_, i|
    if i.even?
      result[i] = even_values.shift
    end
  end
  result
end