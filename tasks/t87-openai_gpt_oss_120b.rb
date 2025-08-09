def get_row(lst, x)
  result = []
  lst.each_with_index do |row, row_idx|
    row.each_with_index do |val, col_idx|
      result << [row_idx, col_idx] if val == x
    end
  end
  result.sort_by { |row_idx, col_idx| [row_idx, -col_idx] }
end