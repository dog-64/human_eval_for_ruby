def min_path(grid, k)
  n = grid.size
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  min_path = nil

  def dfs(grid, x, y, path, k, n, directions, min_path)
    if path.size == k
      if min_path.nil? || path < min_path
        min_path.replace(path.dup)
      end
      return
    end

    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      if nx.between?(0, n - 1) && ny.between?(0, n - 1)
        path << grid[nx][ny]
        dfs(grid, nx, ny, path, k, n, directions, min_path)
        path.pop
      end
    end
  end

  (0...n).each do |i|
    (0...n).each do |j|
      dfs(grid, i, j, [grid[i][j]], k, n, directions, min_path)
    end
  end

  min_path
end