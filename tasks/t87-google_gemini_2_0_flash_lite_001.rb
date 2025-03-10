def get_row(lst, x)
  result = []
  lst.each_with_index do |row, row_index|
    row.each_with_index do |value, col_index|
      if value == x
        result << [row_index, col_index]
      end
    end
  end
  result.sort_by { |row, col| [row, -col] }
end