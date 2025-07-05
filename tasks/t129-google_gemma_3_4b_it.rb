def min_path(grid, k)
  n = grid.length
  q = [[grid[0][0], [grid[0][0]]] ]
  visited = {grid[0][0]}

  while q.length > 0
    curr, path = q.shift
    if path.length == k
      return path
    end

    neighbors = []
    if curr != grid[0][0]
      neighbors << grid[0][0]
    end

    (0..n-1).each do |i|
      if i > 0 && !visited.include?(grid[i][0])
        neighbors << grid[i][0]
      end
    end

    (0..n-1).each do |j|
      if j > 0 && !visited.include?(grid[0][j])
        neighbors << grid[0][j]
      end
    end

    neighbors.each do |neighbor|
      if !visited.include?(neighbor)
        visited << neighbor
        q.push([neighbor, path + [neighbor]])
      end
    end
    neighbors.sort!
  end
  return []
end
