def max_fill(grid, capacity)
  rows, cols = grid.length, grid[0].length
  total_water = 0
  empty_slots = 0

  (0...rows).each do |row|
    (0...cols).each do |col|
      if grid[row][col] == 1
        total_water += 1
      else
        empty_slots += 1
      end
    end
  end

  # Calculate the number of times the bucket needs to be filled
  bucket_fills = (total_water + capacity - 1) / capacity
  empty_slots * bucket_fills
end