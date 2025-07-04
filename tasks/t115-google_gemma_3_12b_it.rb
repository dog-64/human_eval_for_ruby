def max_fill(grid, capacity)
  total_water = 0
  grid.each do |row|
    row.each do |cell|
      total_water += cell
    end
  end

  (total_water + capacity - 1) / capacity
end
