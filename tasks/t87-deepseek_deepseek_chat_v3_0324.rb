def get_row(lst, x)
  result = []
  lst.each_with_index do |row, i|
    row.each_with_index do |val, j|
      result << [i, j] if val == x
    end
  end
  result.sort_by { |i, j| [i, -j] }
end