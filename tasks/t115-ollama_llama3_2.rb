def max_fill(grid, capacity)
  rows = grid.length
  cols = grid[0].length
  total_water = 0
  fill_count = 0

  (rows * cols).times do |i|
    if grid[i / cols][i % cols] == 1
      total_water += 1
    end
  end

  while total_water > 0
    fill_count += 1
    rows.times do |r|
      cols.times do |c|
        next if grid[r][c] == 0
        grid[r][c] -= capacity
        break if grid[r][c] <= 0
      end
    end
    total_water = 0
    (rows * cols).times do |i|
      if grid[i / cols][i % cols] == 1
        total_water += 1
      end
    end
  end

  fill_count
end