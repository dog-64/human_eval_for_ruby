def max_fill(grid, capacity)
  total_water = grid.sum { |row| row.sum }
  (total_water + capacity - 1) / capacity
end