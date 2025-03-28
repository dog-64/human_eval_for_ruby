def sort_even_elements(list)
  even_elements = list[1..-1].sort
  result = []
  (0..list.length - 1).each do |i|
    if i.odd?
      result << list[i]
    else
      result << even_elements.shift
    end
  end
  result
end