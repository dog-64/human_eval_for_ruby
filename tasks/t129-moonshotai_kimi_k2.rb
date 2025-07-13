def min_path(grid, k)
  n = grid.length
  positions = {}
  grid.each_with_index do |row, i|
    row.each_with_index do |val, j|
      positions[val] = [i, j]
    end
  end
  
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  
  queue = []
  (1..n*n).each do |val|
    i, j = positions[val]
    queue << [[val], i, j]
  end
  
  while !queue.empty?
    path, i, j = queue.shift
    return path if path.length == k
    
    directions.each do |di, dj|
      ni, nj = i + di, j + dj
      next if ni < 0 || ni >= n || nj < 0 || nj >= n
      
      next_val = grid[ni][nj]
      new_path = path + [next_val]
      queue << [new_path, ni, nj]
    end
    
    queue.sort_by! { |path, _, _| path }
  end
end