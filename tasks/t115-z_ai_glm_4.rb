
def max_fill(grid, capacity)
  total_dips = 0
  grid.each do |row|
    water_in_row = row.sum
    dips_for_row = (water_in_row + capacity - 1) / capacity
    total_dips += dips_for_row
  end
  total_dips
end