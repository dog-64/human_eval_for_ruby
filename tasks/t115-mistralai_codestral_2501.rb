def max_fill(grid, capacity)
  total_water = grid.flatten.count(1)
  total_water / capacity + (total_water % capacity > 0 ? 1 : 0)
end