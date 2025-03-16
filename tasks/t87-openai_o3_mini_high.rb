def get_row(lst, x)
  result = []
  lst.each_with_index do |row, i|
    row.each_with_index do |value, j|
      result << [i, j] if value == x
    end
  end
  result.sort do |a, b|
    if a[0] == b[0]
      b[1] <=> a[1]
    else
      a[0] <=> b[0]
    end
  end
end