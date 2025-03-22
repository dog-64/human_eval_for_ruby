def max_fill(grid, capacity)
  total = grid.flatten.sum
  (total.to_f / capacity).ceil
end