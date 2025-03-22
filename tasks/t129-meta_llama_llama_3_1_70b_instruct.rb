def min_path(grid, k)
  n = grid.size
  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  min_path = []

  def dfs(i, j, path, visited)
    if path.size == k
      min_path.replace(path.dup)
      return
    end
    visited[i][j] = true
    directions.each do |di, dj|
      ni, nj = i + di, j + dj
      next if ni < 0 || ni >= n || nj < 0 || nj >= n || visited[ni][nj]
      dfs(ni, nj, path + [grid[ni][nj]], visited)
    end
    visited[i][j] = false
  end

  (0...n).each do |i|
    (0...n).each do |j|
      visited = Array.new(n) { Array.new(n, false) }
      dfs(i, j, [grid[i][j]], visited)
    end
    break if min_path.any?
  end
  min_path
end