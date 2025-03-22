def min_path(grid, k)
  n = grid.size
  min_path = []

  def find_path(row, col, current_path)
    if current_path.size == k
      if min_path.empty? || current_path < min_path
        min_path.replace(current_path)
      end
      return
    end

    neighbors = []
    neighbors << [row + 1, col] if row + 1 < n
    neighbors << [row - 1, col] if row - 1 >= 0
    neighbors << [row, col + 1] if col + 1 < n
    neighbors << [row, col - 1] if col - 1 >= 0

    neighbors.sort_by! { |r, c| grid[r][c] }

    neighbors.each do |r, c|
      find_path(r, c, current_path + [grid[r][c]])
    end
  end

  min_val = Float::INFINITY
  start_row, start_col = 0, 0

  grid.each_with_index do |row_values, row_index|
    row_values.each_with_index do |val, col_index|
      if val < min_val
        min_val = val
        start_row, start_col = row_index, col_index
      end
    end
  end

  find_path(start_row, start_col, [grid[start_row][start_col]])
  min_path
end