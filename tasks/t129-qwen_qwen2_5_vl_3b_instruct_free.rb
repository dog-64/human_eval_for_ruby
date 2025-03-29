def min_path(grid, k)
  n = grid.length
  visited = Array.new(n) { Array.new(n, false) }
  path = Array.new(k, 0)

  def dfs(x, y, depth)
    return if depth == k || visited[x][y]
    visited[x][y] = true
    path[depth] = grid[x][y]
    return if depth == k - 1

    directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny]
        dfs(nx, ny, depth + 1)
      end
    end
    visited[x][y] = false
  end

  dfs(0, 0, 0)
  path
end