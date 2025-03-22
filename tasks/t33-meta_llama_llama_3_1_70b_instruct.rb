def sort_third(l)
  sorted_thirds = l.select.with_index { |_, i| i % 3 == 2 }.sort
  l.map.with_index do |e, i|
    i % 3 == 2 ? sorted_thirds.shift : e
  end
end