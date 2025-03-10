def max_fill(grid, capacity)
  total = 0
  grid.each do |row|
    row_sum = row.sum
    total += (row_sum.to_f / capacity).ceil
  end
  total
end