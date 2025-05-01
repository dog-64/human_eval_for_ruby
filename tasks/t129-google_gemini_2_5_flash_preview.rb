def min_path(grid, k)
  n = grid.length
  min_path_result = []
  min_path_values = []

  (0...n).each do |r|
    (0...n).each do |c|
      queue = [[[[r, c]], [grid[r][c]]]]

      while !queue.empty?
        current_path, current_values = queue.shift

        if current_path.length == k
          if min_path_values.empty? || current_values < min_path_values
            min_path_values = current_values
          end
          next
        end

        row, col = current_path.last
        neighbors = [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]]

        neighbors.each do |nr, nc|
          if nr >= 0 && nr < n && nc >= 0 && nc < n
            new_path = current_path + [[nr, nc]]
            new_values = current_values + [grid[nr][nc]]
            queue << [new_path, new_values]
          end
        end
      end
    end
  end

  min_path_values
end
