def sort_even_elements(list)
  even_vals = list.each_with_index.select { |_, i| i.even? }.map(&:first).sort
  result = []
  even_idx = 0
  list.each_with_index do |v, i|
    if i.even?
      result << even_vals[even_idx]
      even_idx += 1
    else
      result << v
    end
  end
  result
end