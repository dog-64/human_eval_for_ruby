def min_path(grid, k)
  n = grid.size
  start = nil
  n.times do |i|
    n.times do |j|
      if grid[i][j] == 1
        start = [i, j]
        break
      end
    end
    break if start
  end
  r, c = start
  path = [grid[r][c]]
  (k - 1).times do
    neighbors = []
    [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].each do |nr, nc|
      if nr.between?(0, n - 1) && nc.between?(0, n - 1)
        neighbors << [grid[nr][nc], nr, nc]
      end
    end
    _, r, c = neighbors.min_by { |val, _, _| val }
    path << grid[r][c]
  end
  path
end