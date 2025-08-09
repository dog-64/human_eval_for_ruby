def max_fill(grid, capacity)
  total = grid.reduce(0) { |sum, row| sum + row.sum }
  return 0 if total == 0
  (total + capacity - 1) / capacity
end