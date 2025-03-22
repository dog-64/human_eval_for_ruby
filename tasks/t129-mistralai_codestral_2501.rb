def min_path(grid, k)
  n = grid.size
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  min_path = []

  def dfs(x, y, path, k, grid, directions, min_path)
    if path.size == k
      min_path.replace(path) if path < min_path
      return
    end

    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      if nx >= 0 && nx < grid.size && ny >= 0 && ny < grid.size && !path.include?(grid[nx][ny])
        dfs(nx, ny, path + [grid[nx][ny]], k, grid, directions, min_path)
      end
    end
  end

  grid.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      dfs(i, j, [cell], k, grid, directions, min_path)
    end
  end

  min_path
end