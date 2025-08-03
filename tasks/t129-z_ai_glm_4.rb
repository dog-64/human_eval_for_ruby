
def min_path(grid, k)
  n = grid.size
  coord_map = {}
  (0...n).each do |i|
    (0...n).each do |j|
      value = grid[i][j]
      coord_map[value] = [i, j]
    end
  end

  min_value = coord_map.keys.min
  path = [min_value]
  current_pos = coord_map[min_value]

  (k - 1).times do
    i, j = current_pos
    neighbors = []
    neighbors << grid[i - 1][j] if i - 1 >= 0
    neighbors << grid[i + 1][j] if i + 1 < n
    neighbors << grid[i][j - 1] if j - 1 >= 0
    neighbors << grid[i][j + 1] if j + 1 < n

    next_val = neighbors.min
    path << next_val
    current_pos = coord_map[next_val]
  end

  path
end