def max_fill(grid, capacity)
  count = 0
  grid.each do |row|
    row.each do |cell|
      if cell == 1
        count += 1
      end
    end
  end
  (count.to_f / capacity).ceil
end