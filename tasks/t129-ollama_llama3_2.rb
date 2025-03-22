def min_path(grid, k)
  n = grid.size
  visited = Array.new(n*n, false)
  queue = [[0]]
  while queue.any?
    path = queue.shift
    x, y = path[-1]
    if visited[x*y] || path.size > k
      next
    end
    visited[x*y] = true
    return path + [grid[x][y]] if path.size == k
    for dx in [-1, 0, 1]
      for dy in [-1, 0, 1]
        nx, ny = x+dx, y+dy
        next if nx < 0 || nx >= n || ny < 0 || ny >= n
        queue << path + [nx*ny]
      end
    end
  end
end