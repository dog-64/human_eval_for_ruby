def max_fill(grid, capacity)
  total = grid.flatten.sum
  (total + capacity - 1) / capacity
end