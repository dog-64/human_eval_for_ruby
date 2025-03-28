def get_row(lst, x)
  result = []
  lst.each_with_index do |row, row_idx|
    row.each_with_index do |cell, col_idx|
      if cell == x
        result << [row_idx, lst.size - col_idx - 1]
      end
    end
  end
  result.sort_by { |coord| [coord[0], -coord[1]] }
end