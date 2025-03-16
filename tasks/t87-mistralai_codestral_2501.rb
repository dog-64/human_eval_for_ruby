def get_row(lst, x)
  result = []
  lst.each_with_index do |row, row_index|
    row.each_with_index do |element, col_index|
      result << [row_index, col_index] if element == x
    end
  end
  result.sort_by { |row, col| [row, -col] }
end