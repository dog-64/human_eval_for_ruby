def min_path(grid, k)
  n = grid.size
  min_val = nil
  cur_i = cur_j = nil
  grid.each_with_index do |row, i|
    row.each_with_index do |val, j|
      if min_val.nil? || val < min_val
        min_val = val
        cur_i = i
        cur_j = j
      end
    end
  end

  result = [min_val]
  return result if k == 1

  dirs = [[-1,0],[1,0],[0,-1],[0,1]]
  (k - 1).times do
    best_val = nil
    best_pos = nil
    dirs.each do |di, dj|
      ni = cur_i + di
      nj = cur_j + dj
      next if ni < 0 || ni >= n || nj < 0 || nj >= n
      val = grid[ni][nj]
      if best_val.nil? || val < best_val
        best_val = val
        best_pos = [ni, nj]
      end
    end
    cur_i, cur_j = best_pos
    result << best_val
  end
  result
end