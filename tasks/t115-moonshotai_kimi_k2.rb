def max_fill(grid, capacity)
  total_water = grid.flatten.count(1)
  (total_water.to_f / capacity).ceil
end