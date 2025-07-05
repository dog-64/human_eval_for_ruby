def get_row(lst, x)
  result = []
  lst.each_with_index do |row, row_index|
    row.each_with_index do |element, col_index|
      if element == x
        result << [row_index, col_index]
      end
    end
  end
  result.sort_by { |row_index, col_index| [row_index, -col_index] }
end