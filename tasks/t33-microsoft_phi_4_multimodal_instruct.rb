def sort_third(l)
  l.each_with_index.map do |value, index|
    index % 3 == 0 ? l.sort[index % (l.length - 1)] : value
  end
end