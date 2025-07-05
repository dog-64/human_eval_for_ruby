def max_fill(grid, capacity)
  total_fills = 0
  current_fill = 0

  grid.each do |row|
    row.each do |cell|
      if cell == 1
        current_fill += 1
        if current_fill == capacity
          total_fills += 1
          current_fill = 0
        end
      end
    end
  end

  total_fills += 1 if current_fill > 0
  total_fills
end