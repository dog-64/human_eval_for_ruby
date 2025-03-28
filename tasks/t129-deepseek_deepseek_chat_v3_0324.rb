def min_path(grid, k)
  n = grid.size
  min_value = grid.flatten.min
  start_positions = []
  grid.each_with_index do |row, i|
    row.each_with_index do |val, j|
      start_positions << [i, j] if val == min_value
    end
  end

  paths = []
  start_positions.each do |i, j|
    visited = []
    path = []
    dfs(grid, i, j, k, path, visited, n)
    paths << path.dup unless path.empty?
  end

  paths.min_by { |p| p }
end

def dfs(grid, i, j, k, path, visited, n)
  return if path.size == k

  path << grid[i][j]
  visited << [i, j]

  if path.size == k
    return
  end

  neighbors = []
  [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |di, dj|
    ni, nj = i + di, j + dj
    if ni.between?(0, n - 1) && nj.between?(0, n - 1) && !visited.include?([ni, nj])
      neighbors << [ni, nj]
    end
  end

  neighbors.sort_by { |ni, nj| grid[ni][nj] }.each do |ni, nj|
    dfs(grid, ni, nj, k, path, visited, n)
    break if path.size == k
  end

  if path.size < k
    path.pop
    visited.pop
  end
end