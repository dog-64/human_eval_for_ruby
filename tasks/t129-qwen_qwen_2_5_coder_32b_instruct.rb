def min_path(grid, k)
  n = grid.length
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  def dfs(x, y, path, visited)
    return path if path.length == k

    min_lex_path = nil
    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      next if nx < 0 || nx >= n || ny < 0 || ny >= n

      new_path = path + [grid[nx][ny]]
      if visited[nx][ny] < k - path.length
        visited[nx][ny] += 1
        candidate_path = dfs(nx, ny, new_path, visited)
        visited[nx][ny] -= 1

        if candidate_path
          min_lex_path ||= candidate_path
          min_lex_path = candidate_path if candidate_path <=> min_lex_path < 0
        end
      end
    end
    min_lex_path
  end

  min_lex_path = nil
  (0...n).each do |i|
    (0...n).each do |j|
      visited = Array.new(n) { Array.new(n, 0) }
      visited[i][j] = 1
      path = dfs(i, j, [grid[i][j]], visited)
      min_lex_path ||= path
      min_lex_path = path if path <=> min_lex_path < 0
    end
  end

  min_lex_path
end