def sort_even_elements(list)
  even_elements = list.each_with_index.select { |el, i| i.even? }.map(&:first).sort
  idx = 0
  list.map.with_index do |el, i|
    if i.even?
      val = even_elements[idx]
      idx += 1
      val
    else
      el
    end
  end
end