def get_row(lst, x)
  coordinates = []
  lst.each_with_index do |row, row_index|
    row.each_with_index do |element, col_index|
      coordinates << [row_index, col_index] if element == x
    end
  end
  coordinates.sort_by { |row, col| [row, -col] }
end