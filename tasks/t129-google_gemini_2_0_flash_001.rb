def min_path(grid, k)
  n = grid.length
  pos = {}
  (0...n).each do |i|
    (0...n).each do |j|
      pos[grid[i][j]] = [i, j]
    end
  end

  path = []
  current = grid.flatten.min
  path << current
  k -= 1

  while k > 0
    x, y = pos[current]
    neighbors = []
    neighbors << [x - 1, y] if x > 0
    neighbors << [x + 1, y] if x < n - 1
    neighbors << [x, y - 1] if y > 0
    neighbors << [x, y + 1] if y < n - 1

    min_neighbor = Float::INFINITY
    neighbors.each do |nx, ny|
      min_neighbor = [min_neighbor, grid[nx][ny]].min
    end

    path << min_neighbor
    current = min_neighbor
    k -= 1
  end

  return path
end