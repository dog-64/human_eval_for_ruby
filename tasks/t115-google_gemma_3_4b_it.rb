def max_fill(grid, capacity)
  total_water = 0
  grid.each do |row|
    row.each do |cell|
      total_water += cell
    end
  end

  if total_water == 0
    return 0
  end

  (total_water.to_f / capacity.to_f).ceil
end
