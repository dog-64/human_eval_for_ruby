def min_path(grid, k)
  n = grid.size
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  result = []

  def dfs(x, y, path, grid, k, directions, result)
    return if path.length > k

    if path.length == k
      result << path.dup
      return
    end

    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      if nx >= 0 && nx < grid.size && ny >= 0 && ny < grid.size
        path << grid[nx][ny]
        dfs(nx, ny, path, grid, k, directions, result)
        path.pop
      end
    end
  end

  (0...n).each do |i|
    (0...n).each do |j|
      dfs(i, j, [grid[i][j]], grid, k, directions, result)
    end
  end

  result.min
end