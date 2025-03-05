def max_fill(grid, capacity)
  total_water = grid.flatten.sum
  (total_water.to_f / capacity).ceil
end