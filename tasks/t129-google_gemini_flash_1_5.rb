```ruby
def min_path(grid, k)
  n = grid.size
  best_path = nil

  def find_path(row, col, current_path, visited)
    current_path << grid[row][col]
    visited << [row, col]

    if current_path.size == k
      if best_path.nil? || current_path < best_path
        best_path = current_path.dup
      end
      return
    end

    moves = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    moves.each do |dr, dc|
      new_row, new_col = row + dr, col + dc
      if new_row >= 0 && new_row < n && new_col >= 0 && new_col < n && !visited.include?([new_row, new_col])
        find_path(new_row, new_col, current_path.dup, visited.dup)
      end
    end
  end

  (0...n).each do |row|
    (0...n).each do |col|
      find_path(row, col, [], [])
    end
  end

  best_path
end
```
