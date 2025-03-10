def min_path(grid, k)
  n = grid.size
  min_path = nil

  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  queue = []
  (0...n).each do |i|
    (0...n).each do |j|
      queue << [[i, j], [grid[i][j]]]
    end
  end

  while !queue.empty?
    (current_pos, path) = queue.shift
    if path.size == k
      if min_path.nil? || path < min_path
        min_path = path
      end
      next
    end

    directions.each do |dx, dy|
      x = current_pos[0] + dx
      y = current_pos[1] + dy
      if x.between?(0, n-1) && y.between?(0, n-1)
        new_path = path.dup
        new_path << grid[x][y]
        queue << [[x, y], new_path]
      end
    end
  end

  min_path
end