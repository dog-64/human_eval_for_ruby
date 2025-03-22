def get_row(lst, x)
  lst.each_with_index.flat_map do |row, row_index|
    row.each_with_index.filter_map do |element, col_index|
      [row_index, col_index] if element == x
    end
  end.sort_by { |row, col| [row, -col] }
end