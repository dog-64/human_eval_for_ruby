def get_row(lst, x)
  result = []
  lst.each_with_index do |row, i|
    row.each_with_index do |element, j|
      result << [i, j] if element == x
    end
  end
  result.sort_by { |a, b| [a, -b] }
end