def min_path(grid, k)
  n = grid.length
  min_path = nil

  def find_paths(row, col, current_path)
    if current_path.length == k
      if min_path.nil? || current_path < min_path
        min_path = current_path.clone
      end
      return
    end

    neighbors = []
    neighbors << [row - 1, col] if row > 0
    neighbors << [row + 1, col] if row < n - 1
    neighbors << [row, col - 1] if col > 0
    neighbors << [row, col + 1] if col < n - 1

    neighbors.each do |neighbor_row, neighbor_col|
      find_paths(neighbor_row, neighbor_col, current_path + [grid[neighbor_row][neighbor_col]])
    end
  end

  (0...n).each do |i|
    (0...n).each do |j|
      find_paths(i, j, [grid[i][j]])
    end
  end

  min_path
end