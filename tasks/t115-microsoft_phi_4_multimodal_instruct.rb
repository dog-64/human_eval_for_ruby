def max_fill(grid, capacity)
  total_wells = grid.flatten.sum
  (total_wells.to_f / capacity).ceil
end
