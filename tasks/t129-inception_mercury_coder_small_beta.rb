def min_path(grid, k)
  n = grid.size
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  min_path = nil

  def dfs(x, y, path, visited)
    if path.size == k
      @min_path = path if @min_path.nil? || path < @min_path
      return
    end

    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      next unless nx.between?(0, n - 1) && ny.between?(0, n - 1)

      if !visited[[nx, ny]]
        visited[[nx, ny]] = true
        dfs(nx, ny, path + [grid[nx][ny]], visited)
        visited[[nx, ny]] = false
      end
    end
  end

  (0...n).each do |i|
    (0...n).each do |j|
      visited = {}
      visited[[i, j]] = true
      dfs(i, j, [grid[i][j]], visited)
    end
  end

  @min_path
end