def max_fill(grid, capacity)
  total_fills = 0
  water_remaining = 0

  grid.each do |row|
    row.each do |cell|
      water_remaining += cell
    end
  end

  total_fills = (water_remaining.to_f / capacity).ceil
  total_fills
end
