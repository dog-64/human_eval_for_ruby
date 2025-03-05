def sort_third(l)
  indices = []
  values = []
  l.each_with_index do |val, index|
    if index % 3 == 0
      indices << index
      values << val
    end
  end

  values.sort!

  result = l.dup
  indices.each_with_index do |index, i|
    result[index] = values[i]
  end

  return result
end