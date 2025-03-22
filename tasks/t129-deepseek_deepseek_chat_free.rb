def min_path(grid, k)
  n = grid.size
  visited = Array.new(n) { Array.new(n, false) }
  moves = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  
  def dfs(grid, visited, x, y, k, path, moves, n)
    return path if k == 0
    visited[x][y] = true
    min_path = nil
    moves.each do |dx, dy|
      nx, ny = x + dx, y + dy
      if nx.between?(0, n-1) && ny.between?(0, n-1) && !visited[nx][ny]
        current_path = dfs(grid, visited, nx, ny, k - 1, path + [grid[nx][ny]], moves, n)
        min_path = current_path if min_path.nil? || current_path < min_path
      end
    end
    visited[x][y] = false
    min_path
  end
  
  min_path = nil
  n.times do |i|
    n.times do |j|
      current_path = dfs(grid, visited, i, j, k - 1, [grid[i][j]], moves, n)
      min_path = current_path if min_path.nil? || current_path < min_path
    end
  end
  min_path
end