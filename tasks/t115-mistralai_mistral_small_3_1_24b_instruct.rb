def max_fill(grid, capacity)
  total_water = grid.flatten.sum
  return 0 if total_water == 0
  (total_water + capacity - 1) / capacity
end