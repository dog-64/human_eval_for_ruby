def sort_third(l)
  multiples_of_three = l.each_index.select { |i| (i + 1) % 3 == 0 }.map { |i| l[i] }.sort
  index = 0
  l.map.with_index do |value, i|
    if (i + 1) % 3 == 0
      multiples_of_three[index]
      index += 1
    else
      value
    end
  end
end