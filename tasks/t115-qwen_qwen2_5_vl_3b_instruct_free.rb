def max_fill(grid, capacity)
  rows, cols = grid.length, grid[0].length
  total_water = 0
  cycle_count = 0

  while total_water < cols * rows
    cycle_count += 1
    total_water = 0
    (0...rows).each do |row|
      (0...cols).each do |col|
        if grid[row][col] == 1
          total_water += 1
          grid[row][col] = 0
          break
        end
      end
    end
  end

  cycle_count
end
