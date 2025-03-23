def max_fill(grid, capacity)
  rows = grid.length
  cols = grid[0].length
  water_count = 0
  grid.each do |row|
    row.each do |cell|
      water_count += cell
    end
  end
  
  return (water_count + capacity - 1) / capacity
end