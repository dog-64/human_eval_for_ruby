def sort_third(l)
  sorted = l.each_with_index.select { |num, i| i % 3 == 0 }.map(&:first).sort
  result = l.dup
  sorted_index = 0
  l.each_index do |i|
    if i % 3 == 0
      result[i] = sorted[sorted_index]
      sorted_index += 1
    end
  end
  result
end