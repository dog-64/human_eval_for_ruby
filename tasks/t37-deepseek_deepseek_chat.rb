def sort_even_elements(list)
  even_elements = list.values_at(* (0...list.length).step(2)).sort
  result = []
  list.each_with_index do |num, index|
    if index.even?
      result << even_elements.shift
    else
      result << num
    end
  end
  result
end